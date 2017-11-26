#!/usr/bin/python3
import bot
import cmd
import argparse
import db

def split_line(count):
    def split_line_deko(func):
        def helper(self, line):
            values = line.split(' ')
            if count == 0:
                return func(self)
            elif count == len(values):
                return func(self, *values)
            elif count > len(values):
                print("Not enough Parameter")
            else:
                print("Too Many Parameter")

        return helper

    return split_line_deko


class shell(cmd.Cmd):
    __twitterbot = bot.twitterbot()
    __db = db.BotDb()

    def do_tweet(self, message):
        self.__twitterbot.tweet(message)

    @split_line(0)
    def do_start(self):
        self.__twitterbot.run()

    @split_line(0)
    def do_limits(self):
        self.__twitterbot.get_limits()

    @split_line(0)
    def do_getTags(self):
        tags = self.__db.get_tags()
        for tag in tags:
            print(tag)

    @split_line(0)
    def do_getOpenTweets(self):
        tweets = self.__db.get_open_tweets()
        for tweet in tweets:
            print(tweet.message)

    @split_line(0)
    def do_exit(self):
        return True

    @split_line(0)
    def do_close(self):
        return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--start", help="Start Bot direct", action="store_true")
    args = parser.parse_args()

    if args.start:
        bot.twitterbot().loop()
    else:
        newshell = shell().cmdloop()


if __name__ == '__main__':
    main()
