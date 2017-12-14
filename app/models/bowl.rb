class Bowl < ActiveRecord::Base
  belongs_to :user
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  # accepts_nested_attributes_for :scraps

  validates :name, presence: :true, :uniqueness => {scope: :user_id}, length: { maximum: 40 }
  validates :user, presence: :true

  def scraps_attributes=(scrap_attributes)
    scrap_attributes.delete_if { |_k, v| v[:description].blank? }
    scrap_attributes.values.each do |scrap_attribute|
      scrap = Scrap.find_or_create_by(scrap_attribute)
      self.scraps << scrap #if scrap.description
    end
  end

  # check if any params are blank and delete them

end
