class Interest < ActiveRecord::Base
  belongs_to :user
  belongs_to :track

  accepts_nested_attributes_for :track

  attr_accessible :track_attributes, :source, :url

  # validates :track_id, presence: true     DO NOT UNCOMMENT, BREAKS EVERYTHING!
  validates :user, presence: true

  default_scope order: 'interests.created_at DESC'
  scope :reverse_order, order('created_at ASC')

  def position
    self.track.interests.reverse_order.index(self) + 1
  end

  def is_last_interest?
    self.track.interests.count == self.position
  end

  def track_attributes=(attrs)
    self.track = Track.where(attrs).first_or_initialize
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

