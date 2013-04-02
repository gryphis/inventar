class PartDesc < ActiveRecord::Base
  attr_accessible :desc, :manufac, :partno, :parttype

  validates :desc,     presence: true
  validates :manufac,  presence: true
  validates :parttype, presence: true
end
