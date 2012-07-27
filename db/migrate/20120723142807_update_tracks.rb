class UpdateTracks < ActiveRecord::Migration
  def up
    execute "INSERT INTO artists (name) SELECT DISTINCT artist FROM tracks"
    add_column(:tracks, :artist_id, :integer)
    # does the above copy the records or cut them?how do i generate an artist_id in place of the :artist values?
  end
  
  def down
    remove_column(:tracks, :artist_id)
  end
end