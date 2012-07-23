require 'spec_helper'

describe Track do

  let(:user) { FactoryGirl.create(:user) }
  before { @track = user.tracks.build(name: "Codex") }

  subject { @track }

  pending # it { should_not respond_to(:artist) }
  it { should     respond_to(:name) }
  it { should     respond_to(:artist_id) }

  it { should be_valid }

  describe "with blank track" do
    before { @track.name = "  " }
    it { should_not be_valid }
  end

  describe "with track entry too long" do
    before { @track.name = "a" * 141 }
    it { should_not be_valid }
  end

end