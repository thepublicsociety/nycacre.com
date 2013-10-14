class AddArticleIdToNewsPhotos < ActiveRecord::Migration
  def change
    add_column :news_photos, :article_id, :integer
  end
end
