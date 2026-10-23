class TopController < ApplicationController
  def main
    render "login_form"
  end

  def login
    user = User.find_by(uid: params[:uid])
    if user && user.authenticate(params[:pass])
      session[:login_uid] = user.uid
      redirect_to tweets_path
    else
      @error = "IDまたはパスワードが違います"
      render "login_form"
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to tweets_path
  end
end