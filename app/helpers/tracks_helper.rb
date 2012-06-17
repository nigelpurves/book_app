module TracksHelper

  def itunes_link(track)
    link_to("iTunes", track.itunes_link, target: '_blank')
  end

  def spotify_link(track)
    link_to("Spotify", track.spotify_link, target: '_blank')
  end
end