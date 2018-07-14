class Rank
  def initialize(_experience, alignment)
    @rank = alignment >= 0 ? 'Captain' : 'Menace'
  end

  def to_s
    @rank.to_s
  end
end
