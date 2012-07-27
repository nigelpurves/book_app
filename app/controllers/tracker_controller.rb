class TrackerController < ApplicationController

  before_filter :find_user_by_token
  before_filter :check_params

  def new
    interest = Interest.build_interest(params[:trackname], params[:artist])
    interest.user = @user
    interest.attributes= {:source => params[:source], :url => params[:href]}

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

  def pad_with_callback body
    callback = params[:callback] || "qusic_callback"
    render :js => "#{callback}(#{body})"
  end

  def check_params
    artist = params[:artist]
    if artist.nil? || artist.empty?
      pad_with_callback JSON.generate({:error => "Invalid parameters!", :response_code => 400})
    end
  end


end
