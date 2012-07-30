class ArtistInterest < Interest
  
  delegate :name, to: :artist
  
  #belongs_to :artist
  attr_accessible :artist

  validates_presence_of :artist

  def position
    self.artist.interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.artist.interests.count == self.position
  end
end
