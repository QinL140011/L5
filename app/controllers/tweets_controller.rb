class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    user = User.find_by(uid: session[:login_uid])
    if user.nil?
      redirect_to top_main_path and return
    end
    @tweet = Tweet.new(message: params[:message], user_id: user.id)
    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def destroy
    Tweet.find(params[:id]).destroy
    redirect_to tweets_path
  end
end