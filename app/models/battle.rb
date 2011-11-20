class Battle < ActiveRecord::Base
  attr_accessible :sender_id, :receiver_id, :winner_id, :accepted
  
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  
  validates :receiver_id, :presence => true
  
  # before_save :set_users
  
  private 
  
  # def set_users
  #   self.sender_id = user_id
  # end
  
    
end
