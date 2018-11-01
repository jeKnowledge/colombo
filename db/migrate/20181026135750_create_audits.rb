class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.string :type
      t.string :address, null: false, defaut: ""
      t.date :date, null: false
      t.string :products, null: false, defaut: ""
      t.boolean :validated, null: false, default: false

      # Report
      t.float :rating, null: false, default: 0
      t.float :price, null: false, default: 0
      t.string :report, null: false, default: ""

      # Report, Plan
      t.references :auditor, index: true

      # Request
      t.references :client, index: true

      t.timestamps
    end
  end
end
