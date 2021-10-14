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
    render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
  end
end
