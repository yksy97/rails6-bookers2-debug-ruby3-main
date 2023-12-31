class RelationshipsController < ApplicationController
   before_action :authenticate_user!
   
def create
  if params[:user_id].present?
    current_user.follow(params[:user_id])
    redirect_to user_path(params[:user_id])
  else
    redirect_to user_path
  end
end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to user_path(params[:user_id])
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end

