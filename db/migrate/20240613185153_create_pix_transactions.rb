class CreatePixTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :pix_transactions do |t|
      t.string :pix_key
      t.decimal :amount
      t.datetime :scheduled_at
      t.string :status

      t.timestamps
    end
  end
end
