class CreateConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :conversations do |t|
      t.belongs_to :auditor, index: true
      t.string :subject
      t.timestamps
    end
  end
end
