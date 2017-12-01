class Bowl < ActiveRecord::Base
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  validates :name, presence: :true, uniqueness: :true, length: { maximum: 40 }

  belongs_to :user

end
