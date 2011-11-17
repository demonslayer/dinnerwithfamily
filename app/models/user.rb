require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :robot, :password, :password_confirmation, :level, :joules, :totalbattles,
                  :totalvictories, :vegetables, :vegetablesthislevel, :health, :maxhealth
                  
  has_many :inventory_items, :dependent => :destroy
  
  image_regex = /.*bot/i
  
  validates :name, :presence => true,
                    :length => { :maximum => 50 },
                    :uniqueness => true
                    
  validates :robot, :presence => true,
                    :format => { :with => image_regex }
                    
  validates :password, :presence => true, :confirmation => true, :on => :create
    
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(name, submitted_password)
    user = find_by_name(name)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    def encrypt_password
      return if password == ""
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end