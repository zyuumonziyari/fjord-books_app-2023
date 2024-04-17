# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(updated_at: :desc, id: :desc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end



## userのCRUD操作に関わる部分はdeviseコントローラー？？

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    session[:user_id] = user.id
    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email_address, :password, :avatar)
    end
    
end
