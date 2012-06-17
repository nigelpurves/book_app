class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :artist
      t.string :name

      t.timestamps
    end
    add_index :tracks, [:created_at]
  end
end
