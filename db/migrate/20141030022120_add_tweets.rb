class AddTweets < ActiveRecord::Migration
  def change
    create_table(:tweets) do |t|
      t.integer :twitter_id
      t.string :full_text
      t.string :tweeted_at

      t.timestamps
    end
  end
end
