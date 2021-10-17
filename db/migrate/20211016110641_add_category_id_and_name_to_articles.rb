class AddCategoryIdAndNameToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :category_id, :integer
    add_column :articles, :category_name, :name
  end
end
