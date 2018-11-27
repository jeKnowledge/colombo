class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :source, null: false, index: true, foreign_key: {to_table: :users}
      t.references :destiny, null: false, index: true, foreign_key: {to_table: :users}
      t.references :audit, null: false
      t.text :body, null: false, default: ""
      t.boolean :read, null: false, default: false
      t.boolean :validated, null: false, default: false

      t.timestamps
    end
  end
end
