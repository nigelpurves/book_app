class RemoveArtistColumnFromTracks < ActiveRecord::Migration
  def up
    rename_column :tracks, :artist, :old_artist_name

    Track.reset_column_information
    Track.each do |track|
      artist = Artist.find_or_create_by_name(track.old_artist_name)
      track.artist = artist
      track.save!
    end

    remove_column(:tracks, :artist)
  end

  def down
    add_column(:tracks, :artist, :string)
  end

end
