require 'spec_helper'

describe "UserInterestsPages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "track creation" do
    before { visit user_interests_path(user) }

    describe "with invalid information" do

      it "should not create a track" do
        expect { click_button "Track this!" }.should_not change(Track, :count)
      end

      describe "error messages" do
        before { click_button "Track this!" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do
        Track.any_instance.stub(:lookup_links)
      end

      describe "should create a track" do

        before  { fill_in 'interest_params[artist_name]',  with: "Lorem Ipsum" }
        before  { fill_in 'interest_params[track_name]',     with: "Lorem Ipsum" }

        it "interest" do
          expect { click_button "Track this!" }.should change(Interest, :count).by(1)
        end

        it "record" do
          expect { click_button "Track this!" }.should change(Track, :count).by(1)
        end
      end

      describe "should create an artist" do
        pending

        before  { fill_in 'interest_params[artist_name]',  with: "Lorem Ipsum" }

        it "interest" do
          expect { click_button "Track this!" }.should change(Interest, :count).by(1)
        end

        it "record" do
          expect { click_button "Track this!" }.should change(Artist, :count).by(1)
        end
      end
    end
  end
end
