class TransactionSerializer < ActiveModel::Serializer
  attributes :id,
              :credit_card_num,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at
end
