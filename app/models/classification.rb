class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    max_length = Classification.joins(boat_classifications: :boat).maximum("boats.length")
    Classification.joins(boat_classifications: :boat).where("length = '#{max_length}'")
  end
end
