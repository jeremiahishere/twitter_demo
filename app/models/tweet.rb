class Tweet < ActiveRecord::Base
  validates :twitter_id, :presence => true
end
