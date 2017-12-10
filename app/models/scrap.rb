class Scrap < ActiveRecord::Base
  belongs_to :user
  has_many :bowl_scraps
  has_many :bowls, through: :bowl_scraps

  accepts_nested_attributes_for :bowls

  validates :description, presence: :true, uniqueness: {scope: :user_id}, length: { maximum: 140 }

  def bowls_attributes=(bowl_attributes)
    bowl_attributes.values.each do |bowl_attribute|
      bowl = Bowl.find_or_create_by(bowl_attribute)
      self.bowls << bowl
    end
  end

end
