class UsersController < ApplicationController
  def index
    query = "SELECT * FROM users"
    @users = User.find_by_sql(query)
  end
  
  def show
    @user = User.find(params[:id])
  end
end
