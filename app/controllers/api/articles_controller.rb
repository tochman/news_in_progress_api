class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create show]
  def index
    articles = Article.get_published_articles(params[:category_name])
    if articles.any?
      render json: articles, each_serializer: Articles::IndexSerializer
      # render :index, layout: false
    else
      render json: { message: 'There are no articles in the database' }, status: 404
    end
  end

  def create
    article = authorize Article.create(article_params.merge(author_ids: [current_user.id] + params[:article][:author_ids]))
    article.category_id = Category.find_by(name: article.category_name)&.id

    if article.valid?
      render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
    else
      render json: { errors: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    article = authorize Article.find(params[:id])
    render json: { article: article }, include: :authors
  end

  private

  def article_params
    params.require(:article).permit(:title, :lede, :body, :category_name, :published, author_ids: [])
  end
end
