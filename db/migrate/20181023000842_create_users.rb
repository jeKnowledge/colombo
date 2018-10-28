class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :type_id, null: false
      t.string :username, null: false, default: ""
      t.string :password, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :address, null: false, default: ""
      t.float :rating, null: false, default: 0
      t.string :qualifications, null: false, default: ""
      t.string :file_path, null: false, default: ""
      t.string :company, null: false, default: ""
      t.boolean :validated, null: false, default: false

      t.timestamps
    end

  end
end
