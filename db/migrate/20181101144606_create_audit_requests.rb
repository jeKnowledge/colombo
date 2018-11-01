class CreateAuditRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :audit_requests do |t|
      t.string :company, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :products, null: false, default: ""
      t.date :date, null: false
      t.references :client, index: true
      t.boolean :validated, null: false, default: false

      t.timestamps
    end
  end
end
