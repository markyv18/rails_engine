class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :status, :merchant_id, :customer_id

  def merchant_name
    (Merchant.find(object.merchant_id)).name
  end

  def customer_name
    (Customer.find(object.customer_id)).name
  end
end
