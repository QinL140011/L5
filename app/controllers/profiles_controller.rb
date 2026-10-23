# app/controllers/profiles_controller.rb
class ProfilesController < ApplicationController
  before_action :require_login
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.includes(:profile).all
  end

  def show
    @profile = @user.profile
  end

  def new
    @user = current_user
    @profile = @user.profile || Profile.new
  end

  def create
    @user = current_user
    @profile = Profile.new(profile_params)
    @profile.user = @user
    if @profile.save
      redirect_to user_profile_path(@user), notice: "プロフィールを登録しました"
    else
      @error = @profile.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @profile = @user.profile || Profile.new
  end

  def update
    @profile = @user.profile
    if @profile.update(profile_params)
      redirect_to user_profile_path(@user), notice: "更新しました"
    else
      @error = @profile.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def profile_params
    params.require(:profile).permit(:message)
  end

  def require_login
    redirect_to top_main_path unless current_user
  end
end