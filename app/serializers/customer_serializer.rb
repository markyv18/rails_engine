class CustomerSerializer < ActiveModel::Serializer
  # has_many :invoices

  attributes :id,
              :name,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
              
  def name
    name = object.first_name + " " + object.last_name
  end
end
