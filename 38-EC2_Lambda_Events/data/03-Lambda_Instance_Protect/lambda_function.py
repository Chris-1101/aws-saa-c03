import boto3
import json

region = 'us-east-1'
ec2 = boto3.client('ec2', region_name=region)


def lambda_handler(event, context):
    print(f'Received event: { json.dumps(event) }')
    instances=[ event['detail']['instance-id'] ]
    ec2.start_instances(InstanceIds=instances)
    print (f'Protected instance stopped - starting up instance: { str(instances) }')

