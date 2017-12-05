class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :bowls
  has_many :scraps

  def self.from_omniauth(access_token)
    data = access_token.info
    binding.pry
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      binding.pry
        user = User.create(
          email: data['email'],
          provider: access_token[:provider],
          uid: access_token[:uid],
          password: Devise.friendly_token[0,20]
        )
    end
    user
  end

end
