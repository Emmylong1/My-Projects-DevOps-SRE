import os
from confluent_kafka import Consumer, KafkaError
import psycopg2

# Kafka Consumer Configuration
conf = {
    'bootstrap.servers': '3.133.112.61:9092',  # Kafka broker address
    'group.id': 'temperature_consumer_group',         # Consumer group ID
    'auto.offset.reset': 'earliest'         # Start consuming from the earliest message
}

# PostgreSQL Database Configuration
db_conn = psycopg2.connect(
    dbname='temperature-database',
    user='postgres',
    password=os.getenv('DB_PASSWORD'),  # Use environment variable for password
    host='3.133.112.61',
    port='5432'
)

# Function to store data in the database
def store_in_database(data):
    cursor = db_conn.cursor()
    # Assuming 'data' is a dictionary representing your message
    # Adjust this query according to your database schema
    insert_query = "INSERT INTO your_table (column1, column2) VALUES (%s, %s)"
    cursor.execute(insert_query, (data['field1'], data['field2']))
    db_conn.commit()
    cursor.close()

# Kafka Consumer
consumer = Consumer(conf)
consumer.subscribe(['temperature_readings'])

try:
    while True:
        msg = consumer.poll(timeout=1.0)
        if msg is None:
            continue
        if msg.error():
            if msg.error().code() == KafkaError._PARTITION_EOF:
                # End of partition, the consumer has reached the end of the log
                continue
            else:
                # Handle other errors
                print(msg.error())
                break
        # Process message
        data = msg.value().decode('utf-8')
        # Call function to store data in the database
        store_in_database(data)
except KeyboardInterrupt:
    pass
finally:
    # Close Kafka consumer and database connection
    consumer.close()
    db_conn.close()
