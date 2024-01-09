class AuthenticationController < ApplicationController

  def new
    render
  end

  def login
    @user = User.find_by_work_email(login_params[:work_email])
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      flash[:notice] = ""
      response.set_cookie("Authorization", { value: token,  expires: 60.minutes.from_now})
      redirect_to "http://localhost:8020/resources"
    else
      flash[:notice] = "wrong email or password, please try again."
      redirect_to "http://localhost:8020/add_resource"
    end
  end

  def logout
    cookies.delete(:Authorization)
    reset_session
    redirect_to "http://localhost:8020/sign_in"
  end

  private

  def login_params
    params.permit(:work_email, :password)
  end
end
