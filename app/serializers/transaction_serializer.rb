class TransactionSerializer < ActiveModel::Serializer

  attributes :sheet, :qty, :commodity, :port

  def port
    {id: object.port.sector_id, name: object.port.name}
  end

  def sheet
    object.offers.map do |offer|
      offer.final? ? [offer.actor_type, offer.amount, accepted: true] : [offer.actor_type, offer.amount]
    end
  end

end
