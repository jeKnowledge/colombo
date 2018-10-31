class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :source_id, null: false
      t.integer :destiny_id, null: false
      t.text :description, null: false, default: ""
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
