require 'spec_helper'

describe TrackerController do

  before do
    @valid_params   = {artist: "The XX", trackname: "Angels", href: "http://example.com/the/xx?title=angels"}
    @invalid_params = {}
    @tokenless_user = Factory.create(:user)
    @user           = Factory.create(:user, :bookmarklet_token => "valid")
  end

  describe "new on the tracker without a valid user token" do

    before do
      get :new, @valid_params.merge(:token => "invalid")
    end

    it "should respond with with success" do
      response.should be_success
    end

    it "should render a jsonp response" do
      response.body.should == jsonp_of({:error => "Sorry, your bookmarklet token is invalid!", :response_code => 404})
    end

  end

  describe "create on the tracker with valid params" do

    before do
      get :new, @valid_params.merge(:token => "valid")
    end

    it "should respond with with success" do
      response.should be_success
    end

    it "should render a jsonp response" do
      response.body.should == jsonp_of({:message => "Thank you!", :response_code => 200})
    end

  end

  describe "create on the tracker with invalid params" do

    before do
      get :new, @invalid_params.merge(:token => "valid")
    end

    it "should respond with with success" do
      response.should be_success
    end

    it "should render a jsonp response" do
      response.body.should == jsonp_of({:message => "Invalid parameters!", :response_code => 400})
    end

  end

  def jsonp_of hash, callback = "qusic-callback"
    "#{callback}(#{hash.to_json})"
  end

end
