class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :event_id
      t.string :name, null: false
    end

    add_index :rounds, [:name, :event_id], unique: true
  end
end
