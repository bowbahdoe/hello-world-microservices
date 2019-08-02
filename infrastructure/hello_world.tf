provider "aws" {
  profile = "default"
  region = "us-west-2"
}

# Lambda deploy bucket
resource "aws_s3_bucket" "lambda_deploy_bucket" {
  acl = "private"
}

# Hello world lambda

resource "aws_iam_role" "hello_world_iam" {
  name = "hello_world_iam"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "hello_world_code" {
  bucket = "${aws_s3_bucket.lambda_deploy_bucket.id}"
  key    = "hello_world.zip"
  source = "../hello_world/hello_world.zip"
  etag = "${filemd5("../hello_world/hello_world.zip")}"
}

resource "aws_lambda_function" "service_lambda" {
  s3_bucket      = "${aws_s3_bucket.lambda_deploy_bucket.id}"
  s3_key         = "${aws_s3_bucket_object.hello_world_code.id}"
  function_name = "hello_world"
  role          = "${aws_iam_role.hello_world_iam.arn}"
  handler       = "hello_world.hello_world"

  source_code_hash = "${aws_s3_bucket_object.hello_world_code.etag}"

  runtime = "python2.7"
}
