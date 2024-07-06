import json
import boto3

tableName = 'urls'
redirectCodeParam = 'redirectCode'

def lambda_handler(event, context):
    if 'pathParameters' not in event or redirectCodeParam not in event['pathParameters']:
        return {
            'statusCode': 400,
            'body': json.dumps({
                'message': 'Redirect code missing'
            })
        }
    
    redirectCode = event['pathParameters'][redirectCodeParam]
    
    print(f'Processing request code {redirectCode}')
    
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(tableName)
    
    try:
        response = table.query(
            IndexName='CodeIndex',
            KeyConditionExpression='Code = :code',
            ExpressionAttributeValues={
                ':code': redirectCode
            }
        )
        
        if not response['Items'] or len(response['Items']) == 0:
            return {
                'statusCode': 404,
                'body': json.dumps({
                    'message': 'URL not found'
                })
            }
        
        url = response['Items'][0]['URL']
        
        print(f'Redirecting code {redirectCode} to URL {url}')
        
        return {
            'statusCode': 302,
            'headers': {
                'Location': url
            },
            'body': ''
        }
    
    except Exception as e:
        print(e)
        return {
            'statusCode': 500,
            'body': json.dumps({
                'message': str(e)
            })
        }
