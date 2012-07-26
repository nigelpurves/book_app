require 'spec_helper'

describe Artist do

  let(:user) { FactoryGirl.create(:user) }
  before { @artist = FactoryGirl.create(:artist) }

  subject { @artist }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "with blank artist" do
    before { @artist.name = "  " }
    it { should_not be_valid }
  end

  describe "with artist entry too long" do
    before { @artist.name = "a" * 141 }
    it { should_not be_valid }
  end
end
