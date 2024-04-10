class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.order(updated_at: :desc, id: :desc).page(params[:page])
  end
  
  def show
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

end
