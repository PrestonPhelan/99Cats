class User < ApplicationRecord
  attr_reader :password

  after_initialize :ensure_session_token

  has_many :cats
  has_many :cat_rental_requests

  validates :user_name, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  def self.find_by_credentials(username, password)
    @user = User.find_by_user_name(username)
    @user && @user.is_password?(password) ? @user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    until self.save
      self.session_token = generate_session_token
    end
    self.session_token
  end
end
