class User < ActiveRecord::Base
  has_secure_password
  validates :password, confirmation: true
  validates :password, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates :email, uniqueness: {case_sensitive: false}

  def self.authenticate_with_credentials(email, password)
    cleanEmail = email.downcase.strip || email.downcase
    user = User.find_by("LOWER(email) = ?", cleanEmail)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end 
  end
end
