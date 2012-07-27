class RemoveArtistColumnFromTracks < ActiveRecord::Migration
  def up
    remove_column(:tracks, :artist)
  end

  def down
    add_column(:tracks, :artist, :string)
  end
end
