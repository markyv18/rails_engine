class Customer < ApplicationRecord

  def name
    name = self.first_name + " " + self.last_name
  end
end
