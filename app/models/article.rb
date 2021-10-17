class Article < ApplicationRecord
  validates_presence_of :title, :lede, :body, :category_name
  belongs_to :category
end
