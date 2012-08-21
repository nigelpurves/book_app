class Interest < ActiveRecord::Base
  require 'songkickr'

  belongs_to :user
  belongs_to :artist
  belongs_to :track

  attr_accessible :source, :url

  validates :user, presence: true

  default_scope order: 'interests.created_at DESC'
  scope :reverse_order, order('created_at ASC')

  def self.build_track_interest(track_name, artist_name)
    track_record = Track.joins(:artist).where('lower("tracks"."name") = ? AND lower("artists"."name") = ?', track_name.downcase, artist_name.downcase).first
    if track_record.nil?
      artist_record = Artist.first(:conditions => ['lower("artists"."name") = ?', artist_name.downcase])
      if artist_record.nil?
        artist_record = Artist.create(name: artist_name)
      end
      track_record = Track.new(name: track_name, artist: artist_record)
      track_record.lookup_links
      track_record.save
    end
    TrackInterest.new(track: track_record)
  end

  def self.build_artist_interest(artist_name)
    artist_record = Artist.first(:conditions => ['lower("artists"."name") = ?', artist_name.downcase])
    if artist_record.nil?
      artist_record = Artist.create(name: artist_name)
    end
    ArtistInterest.new(artist: artist_record)
  end

  def self.build_interest(track_name, artist_name)
    if track_name.nil? || track_name.empty?
      self.build_artist_interest(artist_name)
    else
      self.build_track_interest(track_name, artist_name)
    end
  end

end# == Schema Information
#
# Table name: interests
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  track_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  source     :string(255)
#  url        :string(255)
#
