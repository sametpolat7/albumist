class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    if params[:search]
      @users = User.where("username ILIKE ?", "%#{params[:search]}%").order(:name)
    else
      @users = User.order(:name)
    end

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'users_list', formats: [:html],  locals: { users: @users } }
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :username,
      :email,
      :street,
      :suite,
      :city,
      :zipcode,
      :phone,
      :website,
      :company
    )
  end
end
