# Local storage for tweets
class Tweet < ActiveRecord::Base
  validates :twitter_id, :presence => true

  scope :by_twitter_id, lambda { |twitter_id| where(:twitter_id => twitter_id) }
  scope :recent_first, lambda { order(:tweeted_at => :desc) }
end
