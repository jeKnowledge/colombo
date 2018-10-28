class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.boolean :validated, null: false, default: false
      t.belongs_to :client, index: true
      t.belongs_to :auditor, index: true
      t.timestamps
    end
  end
end
