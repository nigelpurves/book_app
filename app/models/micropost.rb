class Micropost < ActiveRecord::Base
  attr_accessible :artist, :track
  belongs_to :user
  
  validates :user_id, presence: true
end
