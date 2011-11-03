class User < ActiveRecord::Base
  attr_accessible :name, :robot
  
  image_regex = /.*\.(jpg|gif|png)/i
  
  validates :name, :presence => true,
                    :length => { :maximum => 50 },
                    :uniqueness => true
                    
  validates :robot, :presence => true,
                    :format => { :with => image_regex }
end