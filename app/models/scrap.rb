class Scrap < ActiveRecord::Base
  has_many :bowl_scraps
  has_many :bowls, through: :bowl_scraps

  belongs_to :user
end
