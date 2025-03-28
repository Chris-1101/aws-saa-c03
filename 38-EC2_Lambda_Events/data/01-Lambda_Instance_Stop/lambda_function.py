import boto3
import os

region = 'us-east-1'
ec2 = boto3.client('ec2', region_name=region)


def lambda_handler(event, context):
    instances = os.environ['EC2_INSTANCES'].split(",")
    ec2.stop_instances(InstanceIds=instances)
    print(f'Stopped instances: { str(instances) }')

