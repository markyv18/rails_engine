class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :unit_price, :unit_price_dollars, :merchant_id

  def merchant_name
    (Merchant.find(object.merchant_id)).name
  end

  def unit_price_dollars
    object.unit_price / 100
  end
end
