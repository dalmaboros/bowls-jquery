class Scrap < ActiveRecord::Base
  has_many :bowl_scraps
  has_many :bowls, through: :bowl_scraps

  validates :description, presence: :true, uniqueness: {scope: :user_id}, length: { maximum: 140 }

  belongs_to :user
end
