class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :area_id
      t.integer :round_id

      t.integer :inscrits, default: 0
      t.integer :abstentions, default: 0
      t.integer :votants, default: 0
      t.integer :blancs, default: 0
      t.integer :nuls, default: 0
      t.integer :exprimes, default: 0
    end

    add_index :results, [:area_id, :round_id], unique: true
  end
end
