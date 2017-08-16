class CustomerSerializer < ActiveModel::Serializer
  # has_many :invoices

  attributes :id,
              :first_name,
              :last_name

  def name
    name = object.first_name + " " + object.last_name
  end
end
