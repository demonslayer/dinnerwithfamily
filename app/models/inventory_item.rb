class InventoryItem < ActiveRecord::Base
  attr_accessible :content, :price, :userjoules
  belongs_to :user
  
  validates :userjoules, :numericality => true
  validates_numericality_of :price, :less_than_or_equal_to => Proc.new { |r| r.userjoules }, :allow_blank => true
  
  def set_content
    
  end
    
end
