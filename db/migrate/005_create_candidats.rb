class CreateCandidats < ActiveRecord::Migration[5.2]
  def change
    create_table :candidats do |t|
      t.integer :area_id
      t.integer :round_id

      t.string :nom
      t.string :liste
      t.integer :voix, default: 0
    end

    add_index :candidats, [:nom, :area_id, :round_id], unique: true
  end
end
