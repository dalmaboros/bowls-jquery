class ScrapSerializer < ActiveModel::Serializer
  attributes :id, :description, :category
  
  has_many :bowls
end
