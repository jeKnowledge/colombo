class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.float :price, null: false
      t.belongs_to :report, null: false
      t.belongs_to :client, null: false
      t.belongs_to :auditor, null: false
      t.timestamps
    end
  end
end
