class Article < ApplicationRecord
  validates :title, presence: true
  validates :lede, presence: true
end
