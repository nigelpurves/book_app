require 'spec_helper'

describe Artist do

  let(:user)    { FactoryGirl.create(:user, skusername: 'nigelpurves') }
  let(:artist)  { FactoryGirl.create(:artist, name: "The xx") }
  let(:artist_interest) { FactoryGirl.create(:artist_interest, user: user, artist: artist) }

  subject { artist }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "with blank artist" do
    before { artist.name = "  " }
    it { should_not be_valid }
  end

  describe "with artist entry that's too long" do
    before { artist.name = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "download catalogue on a new artist" do
    before { artist.created_at = Time.now }
    
    it "should download all that artists tracks" do
      expect do
        VCR.use_cassette("artist/thexx", :record => :new_episodes) do
          artist.spotify_catalogue_download
        end
      end.to change(Track, :count).by(32)
    end
  end

  describe "download catalogue on an existing artist" do
    before { artist.name       = "Zulu Winter" }
    before { artist.created_at = 48.hours.ago  }
    
    it "should download all that artists tracks" do
      expect do
        VCR.use_cassette("artist/zuluwinter", :record => :new_episodes) do
          artist.spotify_catalogue_download
        end
      end.to change(Track, :count).by(17)      
    end
  end
end