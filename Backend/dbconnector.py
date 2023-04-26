import mysql.connector


def connect_db():
    conn = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="",
        database="fyp_database"
    )

    return conn


def check_connection():
    conn = connect_db()

    if conn.is_connected():
        print("Connection Successful")

    else:
        print("Connection Failed")


def disconnect_db(conn):
    conn.close()
