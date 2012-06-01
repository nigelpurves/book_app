require 'spec_helper'

describe Micropost do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(artist: "Radiohead", track: "Codex") }
  
  subject { @micropost }
  
  it { should respond_to(:artist) }
  it { should respond_to(:track) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank artist" do
    before { @micropost.artist = "  " }
    it { should_not be_valid }
  end
  
  describe "with artist entry too long" do
    before { @micropost.artist = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "with blank track" do
    before { @micropost.track = "  " }
    it { should_not be_valid }
  end
  
  describe "with track entry too long" do
    before { @micropost.track = "a" * 141 }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
