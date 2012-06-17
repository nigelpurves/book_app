require 'spec_helper'

describe Track do

  let(:user) { FactoryGirl.create(:user) }
  before { @track = user.tracks.build(artist: "Radiohead", name: "Codex") }

  subject { @track }

  it { should respond_to(:artist) }
  it { should respond_to(:track) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @track.user_id = nil }
    it { should_not be_valid }
  end

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

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Track.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
