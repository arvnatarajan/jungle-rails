class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, :case_sensitive => false


  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.squish.downcase)

    return user && user.authenticate(password)

  end

end
