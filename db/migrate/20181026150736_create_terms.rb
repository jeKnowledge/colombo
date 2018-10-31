class CreateTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :terms do |t|
      t.string :title, null: false, default: ""
      t.text :description, null: false, default: ""

      t.timestamps
    end
  end
end
