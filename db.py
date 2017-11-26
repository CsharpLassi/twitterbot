#!/usr/bin/python3

import psycopg2
import os.path
import json


class BotDb:
    class Tweet:
        id = None
        message = None

        def __init__(self, id, messae):
            self.id = id
            self.message = messae

    __connectionString = ""

    def __init__(self, file_path_db=None):

        if file_path_db is None:
            file_path_db = 'db_aut.json'

        access = {'host': '127.0.0.1', 'db': 'BotDb', 'user': 'BotUser', 'password': 'bot'}

        if os.path.isfile(file_path_db):
            with open(file_path_db, 'r') as f:
                access = json.load(f)
        else:
            with open(file_path_db, 'w') as outfile:
                json.dump(access, outfile)

        self.__connectionString = "host='%s' dbname='%s' user='%s' password='%s'" % \
                                  (access['host'], access['db'], access['user'], access['password'])

    def add_try_retweet(self, id):
        func_result = False

        conn = psycopg2.connect(self.__connectionString)
        cursor = conn.cursor()
        query = 'SELECT id FROM retweets WHERE retweet_id = %s'
        cursor.execute(query, (id,))
        result = cursor.fetchone()
        if result is None:
            func_result = True
            query = 'INSERT INTO retweets (retweet_id) VALUES (%s);'
            cursor.execute(query, (id,))
            conn.commit()
        conn.close()
        return func_result

    def get_open_tweets(self):
        conn = psycopg2.connect(self.__connectionString)
        cursor = conn.cursor()
        query = 'SELECT id,message FROM tweets where is_sended = false and send_date < NOW() '
        cursor.execute(query)
        result = [BotDb.Tweet(int(row[0]), row[1]) for row in cursor]
        conn.close()
        return result

    def set_tweet_to_sended(self, id):
        conn = psycopg2.connect(self.__connectionString)
        cursor = conn.cursor()
        query = 'UPDATE tweets SET is_sended = true where id = %s'
        cursor.execute(query, (id,))
        conn.commit()

    def get_tags(self):
        conn = psycopg2.connect(self.__connectionString)
        cursor = conn.cursor()
        query = 'SELECT tag FROM tags'
        cursor.execute(query, (id,))
        result = [row[0] for row in cursor]
        conn.close()
        return result
