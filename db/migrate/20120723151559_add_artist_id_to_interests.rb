class AddArtistIdToInterests < ActiveRecord::Migration
  def up
    add_column(:interests, :artist_id, :integer)
  end
  
  def down
    remove_column(:interests, :artist_id)
  end
end
