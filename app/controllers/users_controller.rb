class UsersController < ApplicationController
  def index
    query = "SELECT * FROM users"
    @users = User.find_by_sql(query)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :nickname, :age_id, :sex_id, :voice_id, :profile)
  end
end
