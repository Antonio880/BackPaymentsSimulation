class AddPixKeyTypeToPixTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :pix_transactions, :pix_key_type, :string
  end
end
