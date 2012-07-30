module TracksHelper

  def itunes_link(track_interest)
    link_to("iTunes", track_interest.itunes_link, target: '_blank')
  end

  def spotify_link(track_interest)
    link_to("Spotify", track_interest.spotify_link, target: '_blank')
  end
end