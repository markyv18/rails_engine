class InvoiceSerializer < ActiveModel::Serializer
  has_many :transactions
  attributes :id, :status, :merchant_name, :customer_name

  def merchant_name
    (Merchant.find(object.merchant_id)).name
  end

  def customer_name
    (Customer.find(object.customer_id)).name
  end
end
