class IDGenerator
  def self.generate_id(n)
    1.upto(n).map { |_| ((0..9).to_a + ('A'..'Z').to_a).sample }.join
  end

  def self.generate_serial
    'SCN00-' + IDGenerator.generate_id(16)
  end
end
