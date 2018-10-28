class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :email, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :company, null: false, default: ""
      t.timestamps
    end
  end
end
