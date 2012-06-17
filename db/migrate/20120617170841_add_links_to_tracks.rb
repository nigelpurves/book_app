class AddLinksToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :spotify_link, :string
    add_column :tracks, :itunes_link, :string
  end
end
