class Part < ActiveRecord::Base
  attr_accessible :datev_id, :desc, :price, :serial

  validates :desc,     presence: true
  validates :price,    numericality: { greater_than_or_equal_to: 0.0 }
  validates :datev_id, uniqueness: true
end
