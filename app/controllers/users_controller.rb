class UsersController < ApplicationController
  before_action :search_user, only: [:index, :search]
  before_action :set_user, only: [:show, :edit, :update]
  def index
    @users = User.where.not(id: current_user.id).order("created_at DESC")
  end
  
  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def search
    @results = @u.result
  end

  private

  def user_params
    params.require(:user).permit(:image, :nickname, :age_id, :sex_id, :voice_id, :platform_id, :favorite_id, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def search_user
    @u = User.ransack(params[:q])
  end
end
