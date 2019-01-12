class CreateForgotPasswords < ActiveRecord::Migration[5.2]
  def change
    create_table :forgot_passwords do |t|
      t.belongs_to :user
      t.string :token, index: true
      t.timestamps
    end
  end
end
