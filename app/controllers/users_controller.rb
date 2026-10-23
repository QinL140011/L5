class UsersController < ApplicationController
  def index
    @users = User.includes(:profile).all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      uid: params[:uid], 
      password: params[:password], 
      password_confirmation: params[:password_confirmation], 
      age:  params[:age]
    )
    if @user.save
      redirect_to users_path, notice: "登録しました"
    else
       @error = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, notice: "削除しました"
  end
end
