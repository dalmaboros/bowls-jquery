class BowlScrap < ActiveRecord::Base
  belongs_to :bowl
  belongs_to :scrap

  validates :priority, numericality: { greater_than: 0, less_than: 4, allow_nil: true }

  accepts_nested_attributes_for :scrap

end
