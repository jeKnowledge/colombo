class CreateAdminNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_notifications do |t|
      t.string :body, null: false, default: ""
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
