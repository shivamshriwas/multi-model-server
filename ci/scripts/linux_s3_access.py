#!/usr/bin/env python
import boto3

S3_BUCKET = "shivam-codebuild-test/Nightly_Runs"

print("**********8test s3 access******8")
s3 = boto3.resource('s3')
bucket = s3.Bucket(S3_BUCKET)
result = bucket.meta.client.list_objects(Bucket=bucket.name,
                                         Delimiter='/')
print(result)