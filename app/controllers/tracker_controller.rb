class TrackerController < ApplicationController

  before_filter :find_user_by_token

  def new
    interest = @user.interests.build(build_attributes)
    if interest.save
      pad_with_callback JSON.generate({:message => "Thank you!", :response_code => 200})
    else
      pad_with_callback JSON.generate({:error => "Invalid parameters!", :response_code => 400})
    end
  end

  private

  def find_user_by_token
    @user = User.find_by_bookmarklet_token(params[:token])
    unless @user.present?
      pad_with_callback JSON.generate({:error => "Sorry, your bookmarklet token is invalid!", :response_code => 404})
    end
  end

  def build_attributes
    {:source => params[:source], :url => params[:href], :track_attributes => {:artist => params[:artist], :name => params[:trackname]}}
  end

  def pad_with_callback body
    callback = params[:callback] || "qusic_callback"
    render :js => "#{callback}(#{body})"
  end


end
