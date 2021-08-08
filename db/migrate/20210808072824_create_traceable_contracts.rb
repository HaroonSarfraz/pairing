class CreateTraceableContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :traceable_contracts do |t|
      t.references :contract

      t.integer :payment_period, default: 0
      t.decimal :premium, precision: 10, scale: 2

      t.datetime :outdated_at
      t.datetime :activated_at

      t.timestamps
    end
  end
end
