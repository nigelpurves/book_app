class StaticPagesController < ApplicationController
  
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
