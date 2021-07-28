class CreateAreas < ActiveRecord::Migration[5.2]
  def change
    create_table :areas do |t|
      t.integer :event_id
      t.string :name, null: false
      t.string :path, null: false
    end

    add_index :areas, [:name, :event_id], unique: true
    add_index :areas, [:path, :event_id], unique: true
  end
end
