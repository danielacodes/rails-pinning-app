class User < ApplicationRecord
  has_many :pins
	validates_presence_of :first_name, :last_name, :email, :password
	validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    @user = User.find_by_email_and_password(email, password)

    if !@user.nil?
      return @user
    else
      return nil
    end
  end

end
