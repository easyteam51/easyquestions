class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profiles_path
      flash[:success] = '更新に成功しました'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end  
  end

  private
  
  def set_user
    @user = User.find(current_user.id)
  end
  
  def user_params
    params.require(:user).permit(:email, :name, :avatar, :avatar_cache, :remove_avatar)
  end
end
