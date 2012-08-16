require 'songkickr'

class SongkickImporter

  def initialize(songkick_username, api_key = nil)
    @username = songkick_username
    @api_key = api_key || Songkick::API_KEY
  end

  def insert_tracked_artists_for_user(user)
    interests = []
    ActiveRecord::Base.transaction do
      sk_tracked_artists.each do |k|
        interest = Interest.build_artist_interest(k)
        interest.user = user
        interest.save
        interests << interest
      end
    end
    interests
  end

  def sk_tracked_artists
    sk_tracked_artist_info.map(&:display_name)
  end

  def sk_tracked_artist_info
    remote = Songkickr::Remote.new @api_key
    sk_info = []
    (1..100).each do |p|
      sk_info << remote.users_tracked_artists(@username, page: p).results
    end
    sk_info.compact.flatten
  end

end
