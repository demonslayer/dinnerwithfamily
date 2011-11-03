class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :robot, :password, :password_confirmation, :level
  
  image_regex = /.*\.(jpg|gif|png)/i
  
  validates :name, :presence => true,
                    :length => { :maximum => 50 },
                    :uniqueness => true
                    
  validates :robot, :presence => true,
                    :format => { :with => image_regex }
                    
  validates :password, :presence => true, :confirmation => true
  
  # before_save :encrypt_password
  
  # def has_password?(submitted_password)
  #   # do stuff
  # end
  
  # private
  # 
  #   def encrypt_password
  #     self.encrypted_password = encrypt(password)
  #   end
  #   
  #   def encrypt(string)
  #     string
  #   end
  
end