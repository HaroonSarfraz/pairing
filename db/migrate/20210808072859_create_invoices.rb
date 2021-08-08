class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.references :traceable_contract

      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
