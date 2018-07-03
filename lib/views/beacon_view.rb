class BeaconView
  def self.render(attributes)
    'none' unless attributes["federation_space"]
    "FedSpace - FedLaw enforced"
  end
end
