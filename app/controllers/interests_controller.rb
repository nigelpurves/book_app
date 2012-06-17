class InterestsController < ApplicationController

  def create
    interest = current_user.interests.build(params[:interest])
    if interest.save
      flash[:success] = "Tracked!"
    else
      flash[:error] = interest.errors.full_messages
    end
    redirect_to current_user
  end

end
