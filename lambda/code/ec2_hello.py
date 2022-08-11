import json

def lambda_handler(event, context):
    print("Instance is Terminated")
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Instance is Terminated!')
    }
