class Users::InterestsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :index, :destroy]
  before_filter :load_index_data, only: [:index]
  before_filter :correct_user, only: :destroy

  def create
    @interest_params = InterestParams.new(params[:interest_params])

    if @interest_params.valid?
      @interest      = @interest_params.build_interest
      @interest.user = current_user

      if @interest.save
        flash[:success] = "Tracked!"
        redirect_to user_interests_path(current_user)
        return
      end
    end

    load_index_data
    render 'index'
  end

  def create_with_songkick
    if current_user.skusername.nil?
      redirect_to edit_user_path(current_user)
    else
      importer = SongkickImporter.new(current_user.skusername)
      interests = importer.insert_tracked_artists_for_user(current_user)
      flash[:success] = "Got #{interests.size} artists from the SongKick user #{current_user.skusername}"
      redirect_to user_interests_path(current_user)
    end
  end

  def index
    @interest_params = InterestParams.new
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
    @user      = User.find(params[:user_id])
    @track_interests = @user.interests.where(:type => "TrackInterest").paginate(page: params[:page])
    @artist_interests = @user.interests.where(:type => "ArtistInterest")
  end
end
