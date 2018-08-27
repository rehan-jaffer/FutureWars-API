class PortTradeSerializer < ActiveModel::Serializer

  attributes :items

  def items
    item_hash = {}
    Port.commodities.map do |commodity|
      item_hash[commodity] = {trading_percent: object.trading_percent(commodity), trade_type: object.trade_type(commodity) }
    end
    item_hash
  end

end
