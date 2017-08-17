class ItemSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :description,
             :unit_price,
             :merchant_id

  def unit_price_dollars
    object.unit_price / 100
  end
end
