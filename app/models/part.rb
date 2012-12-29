class Part < ActiveRecord::Base
  attr_accessible :datevid, :desc, :price, :serial

  validates :desc, :presence => true
end
