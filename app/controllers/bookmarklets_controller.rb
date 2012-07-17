class BookmarkletsController < ApplicationController

  before_filter :signed_in_user,     only: [:new]
  before_filter :assure_token,       only: [:new]

  def new
    @user = current_user
  end


  private

  def assure_token
    unless current_user.has_bookmarklet_token?
      current_user.update_bookmarklet_token!
    end
  end

end
