class Rankings

  def self.experience_levels
    0.upto(22).map { |n| 2**(n) }
  end

  def self.experience_level(exp)
    experience_levels.find_index { |n| n >= exp }
  end

  def self.rank(exp, _=0)
    good_ranks[experience_level(exp)]
  end

  def self.good_ranks
    ["Private", 
     "Private 1st Class", 
     "Lance Corporal", 
     "Corporal", 
     "Sergeant", 
     "Staff Sergeant", 
     "Gunnery Sergeant", 
     "1st Sergeant", 
     "Sergeant Major", 
     "Warrant Officer", 
     "Chief Warrant Officer", 
     "Ensign", 
     "Lieutenant J.G", 
     "Lieutenant", 
     "Lieutenant Commander", 
     "Commander", 
     "Captain", 
     "Commodore", 
     "Rear Admiral", 
     "Vice Admiral", 
     "Admiral", 
     "Fleet Admiral"]
  end
end
