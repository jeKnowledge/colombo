class CreateConsents < ActiveRecord::Migration[5.2]
  def change
    create_table :consents do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""
      t.timestamps
    end
  end
end
