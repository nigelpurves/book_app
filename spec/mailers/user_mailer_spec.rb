require "spec_helper"

describe UserMailer do

  let(:user)    { FactoryGirl.create(:user) }
  let(:artist)  { FactoryGirl.create(:artist, name: "Radiohead") }
  let(:track)   { FactoryGirl.create(:track, name: "Codex", artist: artist, spotify_link: "http://open.spotify.com/track/172TCtYnKdqRFPGjeGFzgc",
                                                  itunes_link: "http://itunes.apple.com/gb/album/codex/id425806837?i=425806908&uo=4") }
  let(:track_interest)  { FactoryGirl.create(:track_interest, user: user, track: track) }
  let(:artist_interest) { FactoryGirl.create(:artist_interest, user: user, artist: artist) }

  before(:each) do
    ActionMailer::Base.deliveries = []
    ArtistInterest.any_instance.stub(:get_new_tracks).and_return([track])
  end

  describe "track available" do
    let(:mail) { ActionMailer::Base.deliveries.first }

    before { UserMailer.track_available(track_interest).deliver }

    it "should have the users email in the 'to'" do
      mail.to.should == [user.email]
    end

    it "should contain the name of the song" do
      mail.body.should =~ /Codex/
    end

    it "should contain the name of the artist" do
      mail.body.should =~ /Radiohead/
    end

    it "should contain a spotify link if available" do
      mail.body.should =~ /http:\/\/open.spotify.com\/track\/172TCtYnKdqRFPGjeGFzgc/
    end

    it "should contain an iTunes link if available" do
      mail.body.should =~ /http:\/\/itunes.apple.com\/gb\/album\/codex\/id425806837\?i=425806908&uo=4/
    end
  end

  describe "new artist releases" do
    let(:mail) { ActionMailer::Base.deliveries.first }

    before { UserMailer.artist_new_release(artist_interest, [track]).deliver }

    it "should have the users email in the 'to'" do
      mail.to.should == [user.email]
    end

    it "should contain the name of the artist" do
      mail.body.should =~ /Radiohead/
    end

    it "should contain the name of the song" do
      mail.body.should =~ /Codex/
    end

    it "should contain a spotify link if available" do
      mail.body.should =~ /http:\/\/open.spotify.com\/track\/172TCtYnKdqRFPGjeGFzgc/
    end

#    it "should contain an iTunes link if available" do
#      mail.body.should =~ /http:\/\/itunes.apple.com\/gb\/album\/codex\/id425806837\?i=425806908&uo=4/
#    end
  end
end
