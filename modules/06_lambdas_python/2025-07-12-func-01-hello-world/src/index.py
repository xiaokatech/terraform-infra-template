# import psycopg2


def lambda_handler(event, context):
    name = event.get("queryStringParameters", {}).get("name", "World")
    return {"statusCode": 200, "body": f"Hello {name}!"}


# import os
# import psycopg2
# from psycopg2 import pool

# # 使用连接池管理数据库连接
# connection_pool = None


# def init_db():
#     global connection_pool
#     if connection_pool is None:
#         connection_pool = psycopg2.pool.SimpleConnectionPool(
#             1,
#             10,
#             host=os.getenv("DB_HOST"),
#             port=os.getenv("DB_PORT"),
#             database=os.getenv("DB_NAME"),
#             user=os.getenv("DB_USER"),
#             password=os.getenv("DB_PASSWORD"),
#         )


# def lambda_handler_db(event, context):
#     init_db()

#     try:
#         connection = connection_pool.getconn()
#         cursor = connection.cursor()

#         # 执行查询
#         cursor.execute("SELECT * FROM your_table LIMIT 1")
#         result = cursor.fetchone()

#         return {"statusCode": 200, "body": str(result)}
#     except Exception as e:
#         return {"statusCode": 500, "body": str(e)}
#     finally:
#         if "cursor" in locals():
#             cursor.close()
#         if "connection" in locals():
#             connection_pool.putconn(connection)
