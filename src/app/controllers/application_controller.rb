class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = cookies['Authorization']
    # header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      redirect_to "http://localhost:8020/sign_in"
    rescue JWT::DecodeError => e
      redirect_to "http://localhost:8020/sign_in"
    end
  end
end
