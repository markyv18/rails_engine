class MerchantSerializer < ActiveModel::Serializer
  has_many :id, :items

  attributes :name
  attributes :revenue

  def revenue
    object.items.sum(:unit_price)
  end
end
