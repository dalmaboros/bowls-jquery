class Scrap < ActiveRecord::Base
  belongs_to :user
  has_many :bowl_scraps
  has_many :bowls, through: :bowl_scraps

  accepts_nested_attributes_for :bowl_scraps

  validates :description, presence: :true, uniqueness: {scope: :user_id}, length: { maximum: 140 }

  scope :no_bowls, -> { includes(:bowls).where( :bowls => { :id => nil } ) }

  def bowls_attributes=(bowl_attributes)
    bowl_attributes.delete_if { |_k, v| v[:name].blank? }
    bowl_attributes.values.each do |bowl_attribute|
      bowl = Bowl.find_or_create_by(name: bowl_attribute[:name], user_id: bowl_attribute[:user_id])
      self.bowl_scraps.build(bowl: bowl, priority: bowl_attributes["0"][:bowl_scraps_attributes]["0"][:priority])
    end
  end

end
