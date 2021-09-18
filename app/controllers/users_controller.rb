class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :search_user, only: [:index, :search]
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers]
  def index
    @users = User.where.not(id: current_user.id).order("created_at DESC")
  end
  
  def show
    if user_signed_in?
      #Entry内のuser_idがcurrent_userと同じEntry
      @currentUserEntry = Entry.where(user_id: current_user.id)
      #Entry内のuser_idがMYPAGEのparams.idと同じEntry
      @userEntry = Entry.where(user_id: @user.id)
        #@user.idとcurrent_user.idが同じでなければ
        unless @user.id == current_user.id
          @currentUserEntry.each do |cu|
            @userEntry.each do |u|
              #もしcurrent_user側のルームidと＠user側のルームidが同じであれば存在するルームに飛ぶ
              if cu.room_id == u.room_id then
                @isRoom = true
                @roomId = cu.room_id
              end
            end
          end
          #ルームが存在していなければルームとエントリーを作成する
          unless @isRoom
            @room = Room.new
            @entry = Entry.new
          end
        end
    end
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
    @users = @u.result
    platform_id = params[:q][:platform_id_eq]
    favorite_id = params[:q][:favorite_id_eq]
    @favorite = Favorite.find_by(id: favorite_id)
  end
  
  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
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
