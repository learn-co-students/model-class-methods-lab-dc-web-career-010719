class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where("length < ?", 20)
  end

  def self.ship
    all.where("length > ?", 20)
  end

  def self.last_three_alphabetically
    all.order("name DESC").limit(3)
  end

  def self.without_a_captain
    all.where(captain_id: nil)
  end

  def self.sailboats
    # sailboats = []
    # all.each do |boat|
    #   boat.classifications.each do |classi|
    #     if classi.name == "Sailboat"
    #       sailboats << boat
    #     end
    #   end
    # end
    # sailboats

    # all.where(classifications: "Sailboat")

    all.includes(:classifications).where(classifications:{name: "Sailboat"})
  end

  def self.with_three_classifications

    # all.includes(:classifications).where()

    #had to look at the solution here :/ -look into joins more
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")

  end



end
