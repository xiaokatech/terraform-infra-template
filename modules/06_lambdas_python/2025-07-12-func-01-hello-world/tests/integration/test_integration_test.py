import json
import os
import boto3
import pytest

# Configuration
# LAMBDA_FUNCTION_NAME = os.getenv("LAMBDA_FUNCTION_NAME", "your-lambda-function-name")
# AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
LAMBDA_FUNCTION_NAME = os.getenv(
    "LAMBDA_FUNCTION_NAME", "2025-07-12-python-func-01-hello-world-staging"
)
AWS_REGION = os.getenv("AWS_REGION", "us-east-1")


@pytest.fixture
def lambda_client():
    """Create a Lambda client"""
    return boto3.client("lambda", region_name=AWS_REGION)


def test_invoke_lambda_default(lambda_client):
    """Test invoking the Lambda function with default parameters"""
    response = lambda_client.invoke(
        FunctionName=LAMBDA_FUNCTION_NAME,
        InvocationType="RequestResponse",
        Payload=json.dumps({}),
    )

    # Parse the response
    payload = json.load(response["Payload"])
    print("payload in integratino test:", payload)
    assert payload["statusCode"] == 200
    assert payload["body"] == "Hello World!"


def test_invoke_lambda_custom_name(lambda_client):
    """Test invoking the Lambda function with a custom name"""
    event = {"queryStringParameters": {"name": "Alice"}}

    response = lambda_client.invoke(
        FunctionName=LAMBDA_FUNCTION_NAME,
        InvocationType="RequestResponse",
        Payload=json.dumps(event),
    )

    # Parse the response
    payload = json.load(response["Payload"])
    print("payload in integratino test:", payload)
    assert payload["statusCode"] == 200
    assert payload["body"] == "Hello Alice!"
