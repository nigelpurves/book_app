class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy

  def show
    @user = User.find(params[:id])
    load_interest_data
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Qusic!"
      redirect_to user_interests_path(@user)
    else
      render 'new'
    end
  end

  def edit
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    parms = params[:user]

    unless parms[:password].nil? || parms[:password].empty?
      @user.validate_password= true
    end

    if @user.update_attributes(parms)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to user_interests_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    sign_out
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to root_path
  end



  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      not_found unless (@user.id == current_user.id)
    end

    def admin_user
      not_found unless current_user.admin?
    end

    def load_interest_data
      @track_interests = @user.interests.where(:type => "TrackInterest").paginate(page: params[:page])
      @artist_interests = @user.interests.where(:type => "ArtistInterest")
    end
end
