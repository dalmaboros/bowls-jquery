class Bowl < ActiveRecord::Base
  belongs_to :user
  has_many :bowl_scraps
  has_many :scraps, through: :bowl_scraps

  validates :name, presence: :true, :uniqueness => {scope: :user_id}, length: { maximum: 40 }
  validates :user, presence: :true

  accepts_nested_attributes_for :bowl_scraps

  scope :no_scraps, -> { Bowl.includes(:scraps).where( :scraps => { :id => nil } ) }

  def scraps_attributes=(scrap_attributes)
    scrap_attributes.delete_if { |_k, v| v[:description].blank? }
    scrap_attributes.values.each do |scrap_attribute|
      scrap = Scrap.find_or_create_by(description: scrap_attribute[:description], user_id: scrap_attribute[:user_id])
      self.bowl_scraps.build(scrap: scrap, priority: scrap_attributes["0"][:bowl_scraps_attributes]["0"][:priority])
    end
  end

end
