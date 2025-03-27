import boto3, json

ses = boto3.client('ses')
FROM_EMAIL_ADDRESS = '${ from_email_address }'


def lambda_handler(event, context):

    # Print event data to logs... 
    print(f'Received event: { json.dumps(event) }')

    # Publish message directly to email, provided by EmailOnly or EmailPar TASK
    ses.send_email(
        Source=FROM_EMAIL_ADDRESS,
        Destination={ 'ToAddresses': [ event['Input']['email'] ] }, 
        Message={
            'Subject': { 'Data': 'Whiskers Commands You to attend!' },
            'Body': { 'Text': { 'Data': event['Input']['message'] }}
        }
    )

    return 'Success!'

