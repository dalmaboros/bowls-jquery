class Bowl < ActiveRecord::Base
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  validates :name, presence: :true, :uniqueness => {scope: :user_id}, length: { maximum: 40 }
  validates :user, presence: :true

  belongs_to :user

end
