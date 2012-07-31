require 'spec_helper'

describe "UserInterestsPages" do

  subject { page }

  let(:user)  { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "interest creation" do
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

        before  { fill_in 'interest_params[artist_name]', with: "Adam Artist" }
        before  { fill_in 'interest_params[track_name]',  with: "Massive Tune" }

        it "interest" do
          expect { click_button "Track this!" }.should change(Interest, :count).by(1)
        end

        it "record" do
          expect { click_button "Track this!" }.should change(Track, :count).by(1)
        end
      end
      
      describe "should render an index of" do

        before  { fill_in 'interest_params[artist_name]', with: "adam artist" }
        before  { fill_in 'interest_params[track_name]',  with: "massive tune" }
        before  { click_button "Track this!" }
        
        describe  "track interests with titlecases" do
          it { should have_selector("table.trackintereststable tr", text: "Adam Artist") }
          it { should have_selector("tr", text: "Massive Tune") }
        
          describe "with the correct user coolness ranking" do
            
            before  { sign_in user2 }
            before  { visit user_interests_path(user2) }
            before  { fill_in 'interest_params[artist_name]', with: "adam artist" }
            before  { fill_in 'interest_params[track_name]',  with: "massive tune" }
            before  { click_button "Track this!" }

            it { should have_selector("table.trackintereststable tr", text: "2nd tracker") }
            
          end
        end
      end

      describe "should create an artist" do

        before  { fill_in 'interest_params[artist_name]',  with: "Lorem Ipsum" }

        it "interest" do
          expect { click_button "Track this!" }.should change(Interest, :count).by(1)
        end

        it "record" do
          expect { click_button "Track this!" }.should change(Artist, :count).by(1)
        end
      end
      
      describe "should render an index of" do

        before  { fill_in 'interest_params[artist_name]',  with: "Sam Singer" }
        before { click_button "Track this!" }
        
        it  "artist interests" do
          page.should have_selector("table.artistintereststable tr", text: "Sam Singer")
        end
      end
    end
  end
end
