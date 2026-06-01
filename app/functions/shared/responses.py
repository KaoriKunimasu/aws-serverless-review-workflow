from typing import Any


def json_response(status_code: int, body: Any) -> dict:
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": body if isinstance(body, str) else __import__("json").dumps(body),
    }
