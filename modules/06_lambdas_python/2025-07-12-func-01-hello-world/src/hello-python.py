def lambda_handler(event, context):
    # message = "Hello {} !".format(event["key1"])
    # print("message")
    # print(message)
    # return {"message": message}
    print("event")
    print(event)
    return "Hello world from python3.12!"
