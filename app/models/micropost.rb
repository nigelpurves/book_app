class Micropost < ActiveRecord::Base
  require 'spotify'

  attr_accessible :artist, :track
  belongs_to :user

  
  validates :artist,  presence: true, length: { maximum: 140 }
  validates :track,   presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  default_scope order: 'microposts.created_at DESC'
  
  def itunes_info
    @info ||=   ITunesSearchAPI.search(
      :term => "#{artist} #{track}", 
      :entity=> "song", 
      :country => "GB", 
      :media => "music", 
      :limit => "1"
    ).first # call .first because this returns an array, by default
  end
  
  def spotify_sinfo
    @sinfo ||= Spotify.search_track(
      "#{artist} #{track}"
    )
  end
end
