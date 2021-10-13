class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :lede
      t.text :body
      t.string :url
      t.date :date 
      t.string :main_image

      t.timestamps
    end
  end
end
