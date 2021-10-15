class Article < ApplicationRecord
  validates_presence_of :title, :lede, :body, :category_id
  belongs_to :category
end
