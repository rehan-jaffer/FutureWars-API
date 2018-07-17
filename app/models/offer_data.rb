class OfferData

  def initialize(offer_data)
    @data = offer_data || {}
  end

  def method_missing(method, *args)

    return @data[method] if @data.has_key?(method)

  end

end
