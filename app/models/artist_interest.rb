class ArtistInterest < Interest

  #belongs_to :artist
  attr_accessible :artist

  validates_presence_of :artist



end
