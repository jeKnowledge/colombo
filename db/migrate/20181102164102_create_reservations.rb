class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.float :price, null: false, default: 0.0
      t.references :plan, null: false
      t.references :client, null: false
      t.references :auditor, null: false
      t.timestamps
    end
  end
end
