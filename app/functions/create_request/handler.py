import json

from shared.responses import json_response


def lambda_handler(event, context):
    raw_body = event.get("body") or "{}"

    try:
        body = json.loads(raw_body)
    except json.JSONDecodeError:
        return json_response(
            400,
            {
                "message": "Request body must be valid JSON."
            },
        )

    return json_response(
        201,
        {
            "message": "Create request function scaffold is ready.",
            "input": body,
        },
    )
