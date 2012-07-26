class Users::InterestsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :index, :destroy]
  before_filter :load_index_data, only: [:index]
  before_filter :correct_user,    only: :destroy

  def create
    @interest = Interest.build_interest(params[:interest][:track_name], params[:interest][:artist_name])
    @interest.user = current_user
# TODO: REFACTOR THIS
    if @interest.valid?
      @interest.track.lookup_links
      @interest.track.save
    end
    if @interest.save
      flash[:success] = "Tracked!"
      redirect_to user_interests_path(current_user)
    else
      load_index_data
      render 'index'
    end
  end
  
  def index
    @interest = @user.interests.build
    @interest.build_track
    @interest.track.build_artist
  end
  
  def destroy
    @interest.destroy
    redirect_to user_interests_path(current_user)
  end
  
  private
  
    def correct_user
      @interest = current_user.interests.find_by_id(params[:id])
      redirect_to user_interests_path(current_user) if @interest.nil?
    end
    
    def load_index_data
      @user = User.find(params[:user_id])
      @interests = @user.interests.paginate(page: params[:page])
    end

end