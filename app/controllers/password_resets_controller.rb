class PasswordResetsController < ApplicationController
  def create
  	user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      redirect_to root_url, :alert => 'Reset link has been sent!'
    else
      redirect_to new_password_reset_path, :alert => 'Invalid email'
    end
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 2.hours.ago
  		redirect_to new_password_reset_path, :alert => 'Password reset has expired.'
  	elsif @user.update_attributes(password_reset_params)
  		redirect_to root_url, :alert => 'Password has been reset!'
  	else
  		render :edit
  	end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def password_reset_params
      params.require(:user).permit(:password, :password_confirmation)
    end  
  		
end
