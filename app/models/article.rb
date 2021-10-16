class Article < ApplicationRecord
  validates_presence_of :title, :lede, :body, :category_id, :category_name
  belongs_to :category
end
