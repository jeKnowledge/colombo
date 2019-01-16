class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :body, null: false, default: ""
      t.boolean :active, null: false, default: false
      t.date :date, null: false, default: Date.today

      t.timestamps
    end
  end
end
