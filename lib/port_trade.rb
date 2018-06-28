class PortTradeString
  def self.get(port_class)
    case port_class
    when 1
      'BSS'
    when 2
      'BSB'
    when 3
      'SBB'
    when 4
      'SSB'
    when 5
      'SBS'
    when 6
      'BSS'
    when 7
      'SSS'
    when 8
      'BBB'
          end
  end
end
