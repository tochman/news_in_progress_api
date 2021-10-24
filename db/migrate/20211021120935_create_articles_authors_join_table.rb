class CreateArticlesAuthorsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :articles, :authors
    add_index :articles_authors, [:article_id, :author_id]
  end
end
