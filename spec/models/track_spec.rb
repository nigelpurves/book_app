require 'spec_helper'

describe Track do

  let(:user) { FactoryGirl.create(:user) }
  let(:artist) { FactoryGirl.create(:artist) }
  before { @track = user.tracks.build(name: "Codex", artist: artist) }

  subject { @track }

  it { should     respond_to(:artist) }
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
# == Schema Information
#
# Table name: tracks
#
#  id           :integer         not null, primary key
#  artist       :string(255)
#  name         :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  spotify_link :string(255)
#  itunes_link  :string(255)
#
