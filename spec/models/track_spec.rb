require 'spec_helper'

describe Track do

  let(:user) { FactoryGirl.create(:user) }
  before { @track = user.tracks.build(artist: "Radiohead", name: "Codex") }

  subject { @track }

  it { should respond_to(:artist) }
  it { should respond_to(:name) }

  it { should be_valid }

  describe "with blank artist" do
    before { @track.artist = "  " }
    it { should_not be_valid }
  end

  describe "with artist entry too long" do
    before { @track.artist = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank track" do
    before { @track.name = "  " }
    it { should_not be_valid }
  end

  describe "with track entry too long" do
    before { @track.name = "a" * 141 }
    it { should_not be_valid }
  end

end
