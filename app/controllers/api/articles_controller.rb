class Api::ArticlesController < ApplicationController
  before_action :authenticate_user!, only: %i[create show]
  def index
    articles = Article.get_published_articles(params[:category_name])
    if articles.any?
      render json: articles, each_serializer: Articles::IndexSerializer
    else
      render json: { message: 'There are no articles in the database' }, status: 404
    end
  end

  def create
    article = authorize Article.new(article_params.merge(author_ids: [current_user.id] + params[:article][:author_ids]))
    article.category_id = Category.find_by(name: article.category_name)&.id
    article.save
    if article.persisted? && attach_image(article)
      binding.pry
      render json: { message: "You have successfully added #{article.title} to the site" }, status: 201
    else
      render json: { errors: article.errors.full_messages.to_sentence }, status: 422
    end
  end

  def show
    article = authorize Article.find(params[:id])
    render json: article, serializer: Articles::ShowSerializer
  end

  private

  def article_params
    params.require(:article).permit(:title, :lede, :body, :category_name, :published, author_ids: [])
  end

  def attach_image(article)
    image_params = params[:article][:image]
    image = decode_base64_string(image_params)
    return false if image.nil?

    decoded_data = Base64.decode64(image[:data])
    io = StringIO.new
    io.puts(decoded_data)
    io.rewind
    article.image.attach(io: io, filename: "#{article.title}.#{image[:extension]}", content_type: image[:type])
  end

  def decode_base64_string(image_params)
    if image_params =~ /^data:(.*?);(.*?),(.*)$/
      object = {}
      object[:type] = Regexp.last_match(1)
      object[:encoder] = Regexp.last_match(2)
      object[:extension] = Regexp.last_match(1).split('/')[1]
      object[:data] = Regexp.last_match(3)
      object
    end
  end
end
