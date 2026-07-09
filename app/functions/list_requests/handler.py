import base64
import json
import logging
import os

import boto3
from botocore.exceptions import ClientError

from shared.responses import error_response, json_response


logger = logging.getLogger()
logger.setLevel(os.environ.get("LOG_LEVEL", "INFO"))

dynamodb = boto3.resource("dynamodb")


def parse_limit(event: dict) -> int:
    raw_limit = (
        event.get("queryStringParameters", {}) or {}
    ).get("limit")

    if raw_limit is None:
        return 20

    try:
        limit = int(raw_limit)
    except (TypeError, ValueError):
        raise ValueError("limit must be an integer.")

    if limit < 1 or limit > 100:
        raise ValueError("limit must be between 1 and 100.")

    return limit


def parse_cursor(event: dict) -> dict | None:
    raw_cursor = (
        event.get("queryStringParameters", {}) or {}
    ).get("cursor")

    if raw_cursor is None:
        return None

    try:
        decoded = base64.urlsafe_b64decode(raw_cursor.encode("utf-8"))
        return json.loads(decoded)
    except (ValueError, json.JSONDecodeError):
        raise ValueError("cursor is invalid.")


def encode_cursor(last_evaluated_key: dict) -> str:
    encoded = json.dumps(last_evaluated_key).encode("utf-8")
    return base64.urlsafe_b64encode(encoded).decode("utf-8")


def to_response_item(item: dict) -> dict:
    return {
        "requestId": item.get("requestId"),
        "title": item.get("title"),
        "requestType": item.get("requestType"),
        "sourceLanguage": item.get("sourceLanguage"),
        "targetLanguage": item.get("targetLanguage"),
        "status": item.get("status"),
        "category": item.get("category"),
        "createdBy": item.get("createdBy"),
        "createdAt": item.get("createdAt"),
        "updatedAt": item.get("updatedAt"),
    }


def lambda_handler(event, context):
    table_name = os.environ.get("WORKFLOW_TABLE_NAME")

    if not table_name:
        logger.error("Missing required environment variable: WORKFLOW_TABLE_NAME")
        return error_response(500, "Server configuration is incomplete.")

    try:
        limit = parse_limit(event)
        cursor = parse_cursor(event)
    except ValueError as exc:
        return error_response(400, str(exc))

    table = dynamodb.Table(table_name)

    scan_kwargs = {"Limit": limit}
    if cursor is not None:
        scan_kwargs["ExclusiveStartKey"] = cursor

    try:
        response = table.scan(**scan_kwargs)
    except ClientError:
        logger.exception("Failed to list workflow requests.")
        return error_response(500, "Failed to list workflow requests.")

    items = response.get("Items", [])
    normalized_items = [to_response_item(item) for item in items]

    normalized_items.sort(
        key=lambda item: item.get("createdAt") or "",
        reverse=True,
    )

    last_evaluated_key = response.get("LastEvaluatedKey")

    return json_response(
        200,
        {
            "items": normalized_items,
            "count": len(normalized_items),
            "hasMore": last_evaluated_key is not None,
            "cursor": encode_cursor(last_evaluated_key)
            if last_evaluated_key is not None
            else None,
        },
    )
