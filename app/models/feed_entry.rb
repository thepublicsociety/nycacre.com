class FeedEntry < ActiveRecord::Base
  attr_accessible :author, :category, :id, :link, :published_date, :title, :user_id, :entry_id, :origin
  belongs_to :user
  
  def self.update_from_feed(feed_url, user, thing)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, user, feed_url, thing)
  end
  
  def self.update_from_posts(posts, user, thing)
    add_entries(posts, user, "acre", thing)
  end
  
  private
  def self.add_entries(entries, user, origin, thing)
    entries.each do |entry|
      unless exists? :entry_id => entry.id, :user_id => user.id
        create!(
          :title         => entry.title,
          :link          => entry.url,
          :published_date => entry.published,
          :entry_id         => entry.id,
          :category => thing,
          :author => entry.author,
          :user_id => user.id,
          :origin => origin
        )
      end
    end
  end
end
