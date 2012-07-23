class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string  :name
      t.string  :spotify_link
    end
  end
end