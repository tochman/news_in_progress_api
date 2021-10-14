class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all
    if articles.any?
      render json: { articles: articles }
    else
      render json: { message: 'There are no articles in the database' }, status: 404
    end
  end

  def create
    article = Article.create(title: params[:title],
                             lede: params[:lede])

    # render json: { message: "You have successfully added #{article.title} to the site" }, status: 201

    # validate!(article)

    # begin
    #   article.validate!
    # rescue StandardError
    #   render json: { message: 'Please add a title to your article' }
    # else
    #   render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
    # end

    if article.title.nil?
      render json: { message: 'Please add a title to your article' }
    elsif article.lede.nil?
      render json: { message: 'Please add a lede to your article' }
    else
      render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
    end
  end

  private

  # def validate!(article)
  #   errors.add(:title, :blank, message: 'Please add a lede to your article') if article.title.nil?
  #   errors.add(:lede, :blank, message: 'Please add a lede to your article') if article.lede.nil?
  # end
end
