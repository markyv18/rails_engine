class InvoiceItemSerializer < ActiveModel::Serializer
<<<<<<< HEAD
  attributes :id,
              :invoice_id,
              :item_id,
              :quantity,
              :unit_price
=======
  attributes :id, :invoice_id, :item_id, :quantity, :unit_price

  def unit_price
    (object.unit_price / 100.00).to_s
  end
>>>>>>> MVA_person_B
end
