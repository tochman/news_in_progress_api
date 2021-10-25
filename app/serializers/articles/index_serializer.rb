class Articles::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :lede, :created_at, :updated_at, :published

  belongs_to :category, serializer: Categories::IndexSerializer
  has_many :authors, serializer: Users::AuthorsIndexSerializer
end
