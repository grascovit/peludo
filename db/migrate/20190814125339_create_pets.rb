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
      t.string :city, null: false, default: ''
      t.string :state, null: false, default: ''
      t.string :country, null: false, default: ''

      t.timestamps
    end
  end
end
