#!/usr/bin/python3

import time
import _thread
import twython.exceptions
from twython import Twython
from db import BotDb
import sys
import os.path
import json


class twitterbot:
    __twitter = None
    __db = None

    def __init__(self, file_path_bot=None, file_path_db=None):

        if file_path_bot is None:
            file_path_bot = 'twitter_aut.json'

        access = {'apiKey': '', 'apiSecret': '', 'accessToken': '', 'accessTokenSecret': ''}

        if os.path.isfile(file_path_bot):
            with open(file_path_bot, 'r') as f:
                access = json.load(f)
        else:
            with open(file_path_bot, 'w') as outfile:
                json.dump(access, outfile)

        self.__twitter = Twython(access['apiKey'], access['apiSecret'], access['accessToken'],
                                 access['accessTokenSecret'])
        self.__db = BotDb(file_path_db=file_path_db)

    def get_limits(self):
        limits = self.__twitter.get_application_rate_limit_status()
        return limits

    def tweet(self, msg):
        self.__twitter.update_status(status=msg)

    def __check_tags(self, tweet_tags, tags):
        for tweet_tag in tweet_tags:
            if tweet_tag in tags:
                return True
        return False

    def __check_tweets(self):
        try:
            tweets = self.__db.get_open_tweets()
            for tweet in tweets:
                self.tweet(tweet.message)
                self.__db.set_tweet_to_sended(tweet.id)
        except twython.exceptions.TwythonError:
            self.__db.set_tweet_to_sended(tweet.id)
        except:
            info = sys.exc_info()
            print(info)

    def loop(self):
        while True:
            self.__check_tweets()

            tags = self.__db.get_tags()
            followers = self.__twitter.get_friends_list()['users']
            for follower in followers:
                screenName = follower["screen_name"]
                tweets = self.__twitter.get_user_timeline(screen_name=screenName, tweet_mode='extended')
                for status in tweets:
                    id = status['id']
                    tweet_tags = [tag['text'].lower() for tag in status['entities']['hashtags']]
                    if self.__check_tags(tweet_tags, tags):
                        if self.__db.add_try_retweet(int(id)):
                            try:
                                self.__twitter.retweet(id=id)
                            except:
                                pass
                            break
            time.sleep(120)

    def run(self):
        _thread.start_new(self.loop, ())
