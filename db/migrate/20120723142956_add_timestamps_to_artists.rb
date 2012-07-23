class AddTimestampsToArtists < ActiveRecord::Migration
  def up
    add_timestamps(:artists)
  end
  
  def down
    remove_timestamps(:artists)
  end
end
