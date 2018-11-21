class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :type
      t.string :username, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :first_name, null: false, default: ""
      t.string :last_name, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.boolean :validated, null: false, default: false, index: true
      t.boolean :terms_accepted, null: false

      # client
      t.string :address, null: false, default: ""
      t.string :company, null: false, default: ""

      # auditor
      t.integer :rating_sum, null: false, default: 0
      t.integer :ratings, null: false, default: 0
      t.string :qualifications, null: false, default: ""
      t.string :cv, null: false, default: ""
      t.timestamps
    end
  end
end
