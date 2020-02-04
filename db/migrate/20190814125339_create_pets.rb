class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.references :breed, foreign_key: true
      t.integer :gender
      t.text :description
      t.references :user, foreign_key: true
      t.integer :situation
      t.string :address, null: false, default: ''
      t.numeric :latitude, null: false, default: 0
      t.numeric :longitude, null: false, default: 0
      t.datetime :deactivated_at
      t.string :state

      t.timestamps
    end
  end
end
