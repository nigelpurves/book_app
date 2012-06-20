class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  accepts_nested_attributes_for :track

  attr_accessible :track_attributes

  validates :track_id, presence: true
  validates :user_id, presence: true

  def position
    self.track.interests.index(self) + 1
  end

  def is_last_interest?
    self.track.interests.count == self.position
  end

  def track_attributes=(attrs)
    self.track = Track.where(attrs).first_or_initialize
  end

end