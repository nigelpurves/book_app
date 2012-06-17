class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.references :user
      t.references :track

      t.timestamps
    end
    add_index :interests, [:user_id, :track_id]
  end
end
