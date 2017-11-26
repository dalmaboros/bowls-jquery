class Bowl < ActiveRecord::Base
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  belongs_to :user
  
end
