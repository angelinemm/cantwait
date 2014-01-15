class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_if_signed, only: [:show, :update]

  def new
    # just show the sign up form view
    @user = User.new
  end

  def show
    # implicit set_user, and then just show the view
  end

  def edit
    # implicit set_user, and then just show the view
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      redirect_to user_events_path, notice: 'User was successfully created.' 
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

    def set_user
       @user = current_user
    end

    def check_if_signed
      if !signed_in?
        redirect_to(root_url)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
