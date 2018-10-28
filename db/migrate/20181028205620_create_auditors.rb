class CreateAuditors < ActiveRecord::Migration[5.2]
  def change
    create_table :auditors do |t|
      t.string :email, null: false, default: ""
      t.float :rating, null: false, default: 0
      t.string :qualifications, null: false, default: ""
      t.string :cv, null: false, default: ""
      t.timestamps
    end
  end
end
