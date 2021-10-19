class Article < ApplicationRecord
  validates_presence_of :title, :lede, :body, :category_name
  belongs_to :category

  def self.get_published_articles(category_name)
    articles_published = Article.where(published: true)
    if Category.pluck(:name).include? category_name
      articles_published.where(category_name: category_name)
    else
      articles_published
    end
  end

end
