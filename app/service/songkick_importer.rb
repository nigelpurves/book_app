require 'songkickr'

class SongkickImporter

  def initialize(songkick_username, api_key = nil)
    @username = songkick_username
    api_key = api_key || Songkick::API_KEY
    @remote = Songkickr::Remote.new api_key
    @artists = []
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
    return @artists unless @artists.empty?

    page = 0

    begin
      page = page + 1
      res = @remote.users_tracked_artists(@username, page: page)
      @artists << res.results.map(&:display_name)
    end while !res.results.empty?

    @artists.compact!
    @artists.flatten!
  end

end
