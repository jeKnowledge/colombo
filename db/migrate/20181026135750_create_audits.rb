class CreateAudits < ActiveRecord::Migration[5.2]
  def change
    create_table :audits do |t|
      t.string :type
      t.date :date, null: false, default: Time.now
      t.string :products, null: false, default: ""
      t.boolean :validated, null: false, default: false
      t.references :auditor, index: true
      t.float :price, null: false, default: 0
      t.string :summary, null: false, default: ""
      t.float :fee, null: false, default: 0

      # Report
      t.integer :rating_sum, null: false, default: 0
      t.integer :ratings, null: false, default: 0
      t.string :report, null: false, default: ""

      t.timestamps
    end
  end
end
