class Scrap < ActiveRecord::Base
  has_many :bowls
  has_many :users, through: :bowls
end
