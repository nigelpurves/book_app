require 'spec_helper'

describe TrackInterest do

  let!(:user)             { FactoryGirl.create(:user) }
  let!(:artist)           { FactoryGirl.create(:artist, name: "The xx") }
  let!(:track)            { FactoryGirl.create(:track, artist: artist, discovered_at: 1.hour.ago) }
  let!(:track_interest)   { FactoryGirl.create(:track_interest,   user: user, artist: artist, track: track) }
  let!(:artist_interest)  { FactoryGirl.create(:artist_interest,  user: user, artist: artist, last_notified_at: 48.hours.ago) }
  
#  before(:all) do
#    artist
#    track
#    artist_interest
#  end
  
  subject { track_interest }
  
  describe "a track interest" do

    it "should notify all relevant users" do
      expect do
        track_interest.notify_user!
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end