class HomeController < ApplicationController

  # homepage for not signed in users
  def index
    redirect_to tweet_path if current_user
  end

  # homepage for signed in users
  def tweet
    if current_user
      client.save_recent_tweets
      @tweets = Tweet.recent_first
    else
      redirect_to root_path
    end
  end

  # send a tweet asynchronously
  def create_tweet
    client.send_tweet(params['Full Text'])
    head 200, content_type: "text/html"
  end

  private

  # Twitter client wrapper
  def client
    if current_user
      unless defined? @client
        @client = TwitterClient.new(current_user)
      end
    end
    @client
  end
end
