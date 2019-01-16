class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :conversation, index: true
      t.boolean :direction, null: false, default: true
      t.text :body, null: false
      t.boolean :read, default: false
      t.timestamps
    end
  end
end
