require 'spec_helper'

describe SongkickImporter do

  let(:importer) { SongkickImporter.new 'nigelpurves' }
  let(:user) { Factory.create(:user) }

  describe "retrieve tracked artists from songkick" do
    use_vcr_cassette("sk/nigelpurves")

    it "should find 596 tracked artists for user nigelpurves" do
      importer.sk_tracked_artists.length.should == 596
      importer.sk_tracked_artists.last.should == "Zola Jesus"
    end

    it "should build tracked artists for the user" do
      result = importer.insert_tracked_artists_for_user(user)
      result.size.should == 596
    end

  end

  describe "when creating artist interests from their tracked artists on Songkick" do
    use_vcr_cassette("sk/nigelpurves")

    it "should build tracked artists attached to the user" do
      importer.insert_tracked_artists_for_user(user)
      user.interests.count.should == 596
    end

  end

  describe "importing from an invalid username" do
    use_vcr_cassette("sk/invalid")

    it "should raise a ResourceNotFound" do
      invalid = SongkickImporter.new 'fgfgfgfgfgfgfgfgfgfgfgfgfgfg'

      expect { invalid.insert_tracked_artists_for_user(user) }.to raise_error(ResourceNotFound)
    end

  end

end
