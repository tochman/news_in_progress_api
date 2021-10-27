class Articles::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :title, :lede, :body, :updated_at, :image

  belongs_to :category, serializer: Categories::IndexSerializer
  has_many :authors, serializer: Users::AuthorsIndexSerializer

  def image
    return nil unless object.image.attached?

    if Rails.env.test?
      rails_blob_url(object.image, only_path: true)
    else
      object.image.service_url(expires_in: 1.hour, disposition: 'inline')
    end
  end

end
