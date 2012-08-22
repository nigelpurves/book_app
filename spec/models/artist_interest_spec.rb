require 'spec_helper'

describe ArtistInterest do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:artist, name: "The xx") }
  let(:other_artist) { FactoryGirl.create(:artist, name: "Engelbert Humperdinck") }

  describe ArtistInterest do

    describe "notifying users" do

      before(:each) do
        track                  = FactoryGirl.create(:track, artist: artist, discovered_at: 1.hour.ago)
        old_track              = FactoryGirl.create(:track, artist: artist, discovered_at: 1.month.ago)
        other_track            = FactoryGirl.create(:track, artist: other_artist, discovered_at: 1.year.ago)
        @artist_interest       = FactoryGirl.create(:artist_interest, user: user, artist: artist, last_notified_at: 48.hours.ago)
        @other_artist_interest = FactoryGirl.create(:artist_interest, user: other_user, artist: other_artist, last_notified_at: 48.hours.ago)
      end

      describe "with new tracks" do

        it "should return new tracks" do
          @artist_interest.get_new_tracks.size.should == 1
        end

        it "should notify all relevant users" do
          expect do
            ArtistInterest.notify_all_users
          end.to change(ActionMailer::Base.deliveries, :count).by(1)
        end

        it "should not return older tracks or other other tracks" do
          @other_artist_interest.get_new_tracks.should be_empty
        end

      end


    end

    describe "being created" do

      it "should set the notification date" do
        ai = Factory.build(:artist_interest, user: user, artist: artist)

        ai.last_notified_at.should be_nil
        ai.save
        ai.last_notified_at.should_not be_nil
      end

      it "should not update the notification date if already given" do
        time = 48.hours.ago
        ai   = Factory.build(:artist_interest, user: user, artist: artist, last_notified_at: time)

        ai.last_notified_at.should == time
        ai.save
        ai.last_notified_at.should == time
      end

    end

  end
end
