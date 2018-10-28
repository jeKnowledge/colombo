class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.integer :type, null: false
      t.string :site, null: false, defaut: ""
      t.string :address, null: false, defaut: ""
      t.date :date, null: false
      t.string :products, null: false, defaut: ""
      t.float :rate, null: false
      t.integer :author_id, null: false, defaut: ""
      t.integer :requester_id, null: false, defaut: ""
      t.boolean :validated, null: false, defaut: false

      t.timestamps
    end
  end
end
