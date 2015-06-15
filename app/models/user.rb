class User < ActiveRecord::Base
  attr_accessor :confirm_password
  
  validates_confirmation_of :confirm_password

  def full_name
    "#{first_name} #{last_name}"
  end
  
  class << self
    def verify?(email_username, unencrypted_password)
      return false unless user = User.where(email: email_username).first || User.where(username: email_username).first
      user.authenticate(unencrypted_password)
    end
  end
  
  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      self[:password] = BCrypt::Password.create(Digest::MD5.hexdigest(unencrypted_password), cost: 4)
    end
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password) == Digest::MD5.hexdigest(unencrypted_password) ? self : false
  end
  
  
end
