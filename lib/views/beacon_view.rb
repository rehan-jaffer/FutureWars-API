class BeaconView
  def self.render(attributes)
    return 'none' unless attributes['federation_space']
    'FedSpace - FedLaw enforced'
  end
end
