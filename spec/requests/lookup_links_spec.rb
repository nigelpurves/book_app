require 'spec_helper'

describe "Looking up links" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  before { visit user_interests_path(user) }

  describe "in Spotify" do

    describe "should return a link for a track that's available in the UK" do
      before do
        VCR.use_cassette("track/codex", :record => :new_episodes) do
          fill_in 'interest_params[artist_name]',  with: "Radiohead"
          fill_in 'interest_params[track_name]',   with: "Codex"
          click_button "Track this!"
        end
      end
        it { should have_link("Spotify") }
#        it { should have_selector("a[href='http://open.spotify.com/track/172TCtYnKdqRFPGjeGFzgc']") }

      describe "even if the first track returned is not available in the UK" do
        before do
          VCR.use_cassette("track/ashakes", :record => :new_episodes) do
            fill_in 'interest_params[artist_name]',  with: "Alabama Shakes"
            fill_in 'interest_params[track_name]',   with: "Hold on"
            click_button "Track this!"
          end
        end
          it { should have_link("Spotify") }
      end
    end

    describe "should not return a link for a track that's not available in the UK" do
      before do
        VCR.use_cassette("track/atdi", :record => :new_episodes) do
          fill_in 'interest_params[artist_name]',  with: "At the Drive-in"
          fill_in 'interest_params[track_name]',   with: "One armed scissor"
          click_button "Track this!"
        end
      end
      it { should_not have_link("Spotify") }
    end

    describe "should not return a tribute or karaoke track" do
        pending
#      before do
#        VCR.use_cassette("track/beatles") do
#          fill_in 'interest_params[artist_attributes][name]', with: "Beatles"
#          fill_in 'interest_params[track_attributes][name]',   with: "Yesterday"
#          click_button "Track this!"
#        end
#      end
#      it { should_not have_link("Spotify") }
    end
  end

  describe "in iTunes" do

    describe "should return a track that's available on iTunes" do
      before do
        VCR.use_cassette("track/codex", :record => :new_episodes) do
          fill_in 'interest_params[artist_name]',  with: "Radiohead"
          fill_in 'interest_params[track_name]',   with: "Codex"
          click_button "Track this!"
        end
      end
        it { should have_link("iTunes") }
    end

    describe "should not return a track that's not available on iTunes" do
      before do
        VCR.use_cassette("track/blah", :record => :new_episodes) do
          fill_in 'interest_params[artist_name]',  with: "asdfghjkl"
          fill_in 'interest_params[track_name]',   with: "qwertyuiop"
          click_button "Track this!"
        end
      end
        it { should_not have_link("iTunes") }
    end

    describe "should not return a tribute or karaoke track" do
      pending
#      before do
#        VCR.use_cassette("track/AC_DC") do
#          fill_in 'interest_params[artist_attributes][name]', with: "AC/DC"
#          fill_in 'interest_params[track_attributes][name]',   with: "Back in Black"
#          click_button "Track this!"
#        end
#      end
#        it { should_not have_link("iTunes") }
    end
  end
end
