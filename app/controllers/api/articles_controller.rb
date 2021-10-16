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
    article = Article.create(article_params)

    if article.valid?
      render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
    else
      render json: { errors: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    article = Article.find(params[:id])
    render json: { article: article }
  end

  private

  def article_params
    params.require(:article).permit(:title, :lede, :body, :category_name, :category_id)
  end
end
