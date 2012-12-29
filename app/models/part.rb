class Part < ActiveRecord::Base
  attr_accessible :datev_id, :desc, :price, :serial

  validates :desc, :presence => true
end
