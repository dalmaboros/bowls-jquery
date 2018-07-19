class BowlSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :scraps, serializer: BowlScrapSerializer
end
