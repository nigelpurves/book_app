class User < ActiveRecord::Base
  require 'songkickr'

  attr_accessible :email, :name, :password, :password_confirmation, :skusername
  has_secure_password

  attr_accessor :validate_password

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

  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?


  def has_bookmarklet_token?
    self.bookmarklet_token.present?
  end

  def update_bookmarklet_token!
    create_bookmarklet_token
    self.save!(:validate => false)
  end

  def password_required?
    @validate_password
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
