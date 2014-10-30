class HomeController < ApplicationController
  def index
    redirect_to tweet_path if current_user
  end

  def tweet
    if current_user
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.secrets.twitter_app_id
        config.consumer_secret     = Rails.application.secrets.twitter_app_secret
        config.access_token        = current_user.identity.token
        config.access_token_secret = current_user.identity.secret
      end

      client.user_timeline.each do |tweet|
        if Tweet.where(:twitter_id => tweet.id).empty?
          t = Tweet.create!(:twitter_id => tweet.id, :full_text => tweet.full_text, :tweeted_at => tweet.created_at)
          puts t.inspect
        else
          puts "tweet already in system: " + tweet.inspect
        end
      end

      @tweets = Tweet.all
    else
      redirect_to root_path
    end
  end
end