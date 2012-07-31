require 'spotify'

class Track < ActiveRecord::Base

  attr_accessible :name, :artist
  has_many :interests
  has_many :users, through: :interests
  belongs_to :artist

  accepts_nested_attributes_for :artist

  validates :artist, presence: true
  validates :name, presence: true, length: {maximum: 140}

  def lookup_links
    lookup_spotify_link
    lookup_itunes_link
  end

  def lookup_spotify_link
    spotify_info = Spotify.search_track("#{artist.name} #{name} NOT karaoke")
    unless spotify_info.nil?
      spotify_available = spotify_info.select { |track| track.album.availability['territories'].split(" ").include? "GB" }.first

      unless spotify_available.nil?
        spotify_id        = spotify_available.href.split("track:")[1]
        self.spotify_link = "http://open.spotify.com/track/#{spotify_id}"
      end
    end
  end

  def lookup_itunes_link
    itunes_info = ITunesSearchAPI.search(
      :term => "#{artist.name} #{name}",
      :entity=> "song",
      :country => "GB",
      :media   => "music",
      :limit   => "1"
    ).first

    self.itunes_link = itunes_info["trackViewUrl"] if itunes_info.present?
  end

  def self.update_links
    tracks = self.where("itunes_link IS NULL OR spotify_link IS NULL").all

    tracks.each do |track|
      track.lookup_links
      if track.spotify_link_changed? || track.itunes_link_changed?
        track.save!
        track.interests.each do |interest|
          UserMailer.song_available(interest).deliver
        end
      end
    end
  end

  def self.force_update
    self.all.each do |track|
      track.spotify_link = nil
      track.itunes_link  = nil
      track.save
      track.lookup_links
      if track.spotify_link_changed? || track.itunes_link_changed?
        track.save
      end
    end
  end
end
# == Schema Information
#
# Table name: tracks
#
#  id           :integer         not null, primary key
#  artist       :string(255)
#  name         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  spotify_link :string(255)
#  itunes_link  :string(255)
#

