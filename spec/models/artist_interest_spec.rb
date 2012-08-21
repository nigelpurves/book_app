require 'spec_helper'

describe ArtistInterest do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:artist) { FactoryGirl.create(:artist, name: "The xx") }
  let!(:track) { FactoryGirl.create(:track, artist: artist, discovered_at: 1.hour.ago) }
  let!(:artist_interest) { FactoryGirl.create(:artist_interest, user: user, artist: artist, last_notified_at: 48.hours.ago) }

#  before(:all) do
#    artist
#    track
#    artist_interest
#  end

  subject { artist_interest }

  describe "an artist interest" do

    it "should return new tracks" do
      artist_interest.get_new_tracks.should_not be_empty
    end

    it "should notify all relevant users" do
      expect do
        ArtistInterest.notify_all_users
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
    end

    it "should set the notification date before creation" do
      ai = Factory.build(:artist_interest, user: user, artist: artist)

      ai.last_notified_at.should be_nil
      ai.save
      ai.last_notified_at.should_not be_nil
    end

    it "should not update the notification date if already given" do
      time = 48.hours.ago
      ai = Factory.build(:artist_interest, user: user, artist: artist, last_notified_at: time)

      ai.last_notified_at.should == time
      ai.save
      ai.last_notified_at.should == time
    end

  end
end
