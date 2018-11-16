class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.float :price, null: false, default: 0.0
      t.references :report, null: false
      t.references :client, null: false
      t.references :auditor, null: false
      t.timestamps
    end
  end
end
