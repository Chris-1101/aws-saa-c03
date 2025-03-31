# Top 10 Cats -- S3 Static Website Bheind CloudFront CDN

Rather than Terraform a Lambda function whose only function is to copy files from Adrian's bucket into our own, we can simply use the AWS cli.

Once the configuration has been applied, run the following command:
```bash
aws s3 cp s3://cl-randomstuffforlessons/cloud_front_and_s3 s3://BUCKET_NAME --recursive --profile 'PROFILE_NAME'
```

