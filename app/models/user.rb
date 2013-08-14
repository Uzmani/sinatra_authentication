class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users
  include BCrypt
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  attr_writer :confirm_password
  
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    return nil if user.nil?

    user.password == password ? user : nil
    
  end

  def password
      @password ||= Password.new(password_hash)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
    end

end
