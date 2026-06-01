from shared.responses import json_response


def lambda_handler(event, context):
    return json_response(
        200,
        {
            "items": [],
            "count": 0,
            "message": "List requests function scaffold is ready."
        },
    )
