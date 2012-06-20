class TracksController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy

  def create
    @tracks = current_user.tracks.paginate(page: params[:page])
    @track = current_user.tracks.build(params[:track])
    if @track.save
      flash[:success] = "Tracked!"
    else
      flash[:error] = track.errors.full_messages
    end
    redirect_to root_path
  end

  def destroy
    @track.destroy
    redirect_to root_path
  end

  private

    def correct_user
      @track = current_user.tracks.find_by_id(params[:id])
      redirect_to root_path if @track.nil?
    end
end