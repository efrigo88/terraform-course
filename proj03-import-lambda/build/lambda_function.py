import json

print("Loading function")


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hey emif!! Hello from Lambda!"
    }
