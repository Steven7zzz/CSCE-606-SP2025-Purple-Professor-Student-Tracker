class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # def self.from_google(auth)
  #   where(email: auth.info.email).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #   end
  # end

  def self.from_google(auth)
    user = find_by(email: auth.info.email) # Only allow users already in DB

    unless user
      Rails.logger.warn "Unauthorized login attempt for #{auth.info.email}"
      return nil
    end

    user
  end
end
