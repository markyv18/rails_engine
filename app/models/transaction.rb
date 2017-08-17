class Transaction < ApplicationRecord
  belongs_to :invoice

  scope :successful, -> { where(result: 'success') }

  def self.random
    order("RANDOM()").first
  end


end
