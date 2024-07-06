import uuid
import random 
import os
import json

import boto3
# from boto3.dynamodb.conditions import Key

TABLE_NAME = 'urls'
BASE_URL = os.getenv('BASE_URL', '')

def generate_code():
    # generates a random code
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    return ''.join(random.choice(alphabet) for _ in range(7))

def handler(event, context):
    try:
        request_body = event.get('body')
        if not request_body:
            return {
                'statusCode': 400,
                'body': 'Invalid request body'
            }

        request_data = json.loads(request_body)
        url = request_data.get('url')

        if not url:
            return {
                'statusCode': 400,
                'body': 'URL is required'
            }

        client = boto3.client('dynamodb')
        dynamodb = boto3.resource('dynamodb')
        table = dynamodb.Table(TABLE_NAME)

        item_id = str(uuid.uuid4())
        code = generate_code()

        table.put_item(
            Item={
                'ID': item_id,
                'Code': code,
                'URL': url
            }
        )

        response = {
            'id': item_id,
            'shortUrl': BASE_URL + code,
            'url': url
        }

        return {
            'statusCode': 201,
            'body': json.dumps(response) 
        }

    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': 'An error occurred'
        }
