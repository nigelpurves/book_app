require 'spec_helper'

describe Interest do

  before do
    Track.any_instance.stub(:lookup_links)
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:interest) { FactoryGirl.create(:track_interest, user: user) }

  subject { interest }

  it { should respond_to(:track_id) }
  it { should respond_to(:artist_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  # it { should be_valid }
  it { puts interest.errors.full_messages }

  describe "when user_id is not present" do
    before { interest.update_attribute(:user, nil) }
    it { should_not be_valid }
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Interest.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
# == Schema Information
#
# Table name: interests
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  track_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  source     :string(255)
#  url        :string(255)
#
