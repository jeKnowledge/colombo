class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.float :price, null: false
      t.belongs_to :plan, null: false
      t.belongs_to :client, null: false
      t.belongs_to :auditor, null: false
      t.timestamps
    end
  end
end
