import json


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps(
            {
                "message": "hello world, today is today 2222!",
                # "location": ip.text.replace("\n", "")
            }
        ),
    }
