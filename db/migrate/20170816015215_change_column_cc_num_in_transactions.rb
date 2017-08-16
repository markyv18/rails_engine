class ChangeColumnCcNumInTransactions < ActiveRecord::Migration[5.0]
  def change
    rename_column :transactions, :credit_card_num, :credit_card_number
  end
end
