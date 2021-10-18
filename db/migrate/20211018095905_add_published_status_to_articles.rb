class AddPublishedStatusToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :published, :boolean
  end
end
