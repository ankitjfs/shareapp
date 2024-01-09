class AllotmentsController < ApplicationController
  before_action :authorize_request
  before_action :find_allotment, except: [:create, :index]

  def new
    render
  end

  def index
    params[:user_id] = !@current_user.nil? && @current_user.id
    @allotments = Allotment.filter(params.slice(:resource_id, :user_id, :status))
    render json: @allotments, status: :ok
  end

  # POST /allotments
  def create
    params[:user_id] = !@current_user.nil? && @current_user.id
    @allotment = Allotment.new(allotment_params)
    if @allotment.save
      redirect_to "http://localhost:8020/resources"
    else
      render json: { errors: @allotment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /allotments/{:id}
  def update
    unless @allotment.update(allotment_params)
      render json: { errors: @allotment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_allotment
    @allotment = Allotment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'allotment not found' }, status: :not_found
  end

  def allotment_params
    params.permit(:resource_id, :user_id, :status)
  end
end