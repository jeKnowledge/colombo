class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.string :type
      t.string :site, null: false, defaut: ""
      t.string :address, null: false, defaut: ""
      t.date :date, null: false, default: Date.today
      t.string :products, null: false, defaut: ""
      t.boolean :validated, null: false, default: false

      # Report
      t.float :rate, null: false, default: 0
      # Report, Plan
      t.belongs_to :auditor, index: true
      # Request
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
