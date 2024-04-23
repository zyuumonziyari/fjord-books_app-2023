# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
    @users = User.order(updated_at: :desc, id: :desc).page(params[:page])
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
