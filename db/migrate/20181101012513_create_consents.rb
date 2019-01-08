class CreateConsents < ActiveRecord::Migration[5.2]
  def change
    create_table :consents do |t|
      t.integer :type_id, null: false
      t.text :description, null: false, default: ""
      t.boolean :active, null: false, default: false
      t.timestamps
    end
  end
end
