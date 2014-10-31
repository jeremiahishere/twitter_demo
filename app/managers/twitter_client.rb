# Wrapper for the twitter client
# just for convenience for now
class TwitterClient
  attr_reader :client

  # @param authed_user [User] User authenticated through twitter oauth
  def initialize(authed_user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_app_id
      config.consumer_secret     = Rails.application.secrets.twitter_app_secret
      config.access_token        = authed_user.identity.token
      config.access_token_secret = authed_user.identity.secret
    end
  end

  # Pull the 20 most recent tweets in the user's timeline and save them to the database
  # Use the twitter id to avoid duplicates
  def save_recent_tweets
    @client.user_timeline.each do |tweet|
      if Tweet.by_twitter_id(tweet.id).empty?
        t = Tweet.create!(:twitter_id => tweet.id, :full_text => tweet.full_text, :tweeted_at => tweet.created_at)
        puts t.inspect
      else
        puts "tweet already in system: " + tweet.inspect
      end
    end
  end

  # wrapper for the update method on the client
  def send_tweet(message)
    @client.update(message)
  end
end
