class BowlScrap < ActiveRecord::Base
  belongs_to :bowl
  belongs_to :scrap

  validates :priority, numericality: { greater_than: 0, less_than: 4, allow_nil: true }
  validates :bowl_id, :uniqueness => { :scope => :scrap_id }

end
