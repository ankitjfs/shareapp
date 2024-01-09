class ResourcesController < ApplicationController
  before_action :authorize_request

  def index
    search_term = params[:search]
    if search_term.nil? || search_term.empty? || search_term.strip.nil?
      search_term = "*"
    end

    where_clause = {company_id: @current_user.company_id, status: "available"}

    if !params[:only_personal_resource].nil? && params[:only_personal_resource] == "on"
        where_clause[:user_id] =  @current_user.id
    else if !params[:only_company_resource].nil? && params[:only_company_resource] == "on"
        where_clause[:user_id] =  {not: @current_user.id}
         end
    end

    @resources = Resource.search(search_term, fields: [{name: :text_middle}, {description: :text_middle}], where: where_clause)
  end

  def new
    render
  end

  def show
    @resource = Resource.find(params[:id])
    render json: @resource, status: :ok
  end

  # POST /resources
  def create
    params[:user_id] = !@current_user.id.nil? && @current_user.id
    params[:company_id] = !@current_user.company_id.nil? && @current_user.company_id
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to "http://localhost:8020/resources"
    else
      # render json: { errors: @resource.errors.full_messages }, status: :unprocessable_entity
      redirect_to "http://localhost:8020/resources"
    end
  end

  # PUT /resources/{:id}
  def update
    @resource = Resource.find(params[:id])
    unless  @resource.update(resource_params)
      render json: { errors:  @resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def resource_params
    params.permit(:name, :description, :user_id, :company_id, :status)
  end

end
