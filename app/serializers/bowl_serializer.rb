class BowlSerializer < ActiveModel::Serializer
  attributes :id

  has_many :scraps, serializer: BowlScrapSerializer
end
