class User < ActiveRecord::Base
  require 'songkickr'

  
  attr_accessible :email, :name, :password, :password_confirmation, :skusername
  has_secure_password

  has_many :interests, dependent: :destroy
  has_many :tracks, through: :interests
  has_many :artists, through: :interests     # CHANGED THIS TO THROUGH: :INTERESTS FROM THROUGH: :TRACKS - WILL THAT WORK?!?!?

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  
  def has_bookmarklet_token?
    self.bookmarklet_token.present?
  end

  def update_bookmarklet_token!
    create_bookmarklet_token
    self.save!(:validate => false)
  end
  
  def save_sk_tracked_artists
    self.sk_tracked_artists.each do |k|
      Interest.build_artist_interest(k)
    end
  end
  
  def sk_tracked_artists
    sk = []
    self.sk_tracked_artist_info.each do |s|
      sk << s.display_name
    end
    sk
  end
  
  def sk_tracked_artist_info
    remote = Songkickr::Remote.new 'pNAGmi2khmWjJxT2'
    sk_info = []
    (1..100).each do |p|      
      sk_info << remote.users_tracked_artists(skusername, page: p).results
    end
    sk_info.compact.flatten
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def create_bookmarklet_token
      self.bookmarklet_token = SecureRandom.urlsafe_base64
    end


end
# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  name              :string(255)
#  email             :string(255)
#  created_at        :datetime        not null
#  updated_at        :datetime        not null
#  password_digest   :string(255)
#  remember_token    :string(255)
#  admin             :boolean         default(FALSE)
#  bookmarklet_token :string(255)
#