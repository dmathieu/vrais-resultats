# frozen_string_literal: true

class CreateCandidats < ActiveRecord::Migration[5.2]
  def change
    create_table :candidats do |t|
      t.integer :result_id

      t.string :nom
      t.string :liste
      t.integer :voix, default: 0
    end

    add_index :candidats, %i[nom result_id], unique: true
  end
end
