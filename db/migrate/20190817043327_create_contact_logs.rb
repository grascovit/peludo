class CreateContactLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_logs do |t|
      t.references :requesting_user, foreign_key: { to_table: :users }
      t.references :requested_user, foreign_key: { to_table: :users }
      t.references :pet, foreign_key: true

      t.timestamps
    end
  end
end
