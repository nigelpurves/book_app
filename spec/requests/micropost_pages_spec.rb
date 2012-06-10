require 'spec_helper'

describe "MicropostPages" do

  subject { page }
  
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
      
      it "should not create a micropost" do
        expect { click_button "Track this!" }.should_not change(Micropost, :count)
      end
      
      describe "error messages" do
        before { click_button "Track this!" }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      
      before { fill_in 'micropost_artist', with: "Lorem Ipsum" }
      before { fill_in 'micropost_track', with: "Lorem Ipsum" }
      it "should create a micropost" do
        expect { click_button "Track this!" }.should change(Micropost, :count).by(1)
      end
    end
  end
end
