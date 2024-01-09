class UsersController < ApplicationController
  before_action :authorize_request, except: [:create, :new] #add before_action logic only in ApplicationController
  before_action :find_user, except: [:create, :new]

  # GET /users/{:id}
  def show
    render
  end

  def new
    render
  end


  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # render json: @user, status: :created
      redirect_to "http://localhost:8020/sign_in"
    else
      flash[:alert] = @user.errors.full_messages
      redirect_to "http://localhost:8020/sign_up"
    end
  end

  # PUT /users/{:id}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_user
    params[:id] = !@current_user.nil? && @current_user.id
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params # add before
    params.permit(:first_name, :last_name, :work_email, :company_id, :password, :password_confirmation, :status)
  end

end