class HomeController < ApplicationController

  skip_before_filter :require_login

  def index

    if @current_user and @current_user.id > 0
      redirect_to fieldnotes_path

    elsif User.count.eql? 0
      @user = User.new
      render 'new_install'

    else
      render 'sessions/new'

    end
  end
end
