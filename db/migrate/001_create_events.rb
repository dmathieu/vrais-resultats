# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.integer :annee

      t.boolean :populated
    end

    add_index :events, :name, unique: true
  end
end
