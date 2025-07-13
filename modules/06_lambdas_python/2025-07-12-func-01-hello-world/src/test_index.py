from index import handler


def test_lambda_handler_default():
    event = {}
    response = handler(event, None)
    assert response["statusCode"] == 200
    assert response["body"] == "Hello World!"


def test_lambda_handler_custom_name():
    event = {"queryStringParameters": {"name": "Alice"}}
    response = handler(event, None)
    assert response["body"] == "Hello Alice!"
