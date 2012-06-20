class InterestsController < ApplicationController
  before_filter :signed_in_user,  only: [:create, :destroy]
  before_filter :correct_user,    only: :destroy

  def create
    interest = current_user.interests.build(params[:interest])
    if interest.save
      flash[:success] = "Tracked!"
    else
      flash[:error] = interest.errors.full_messages
    end
    redirect_to root_path
  end
  
  def destroy
    @interest.destroy
    redirect_to root_path
  end
  
  private
  
    def correct_user
      @interest = current_user.interests.find_by_id(params[:id])
      redirect_to root_path if @interest.nil?
    end

end
