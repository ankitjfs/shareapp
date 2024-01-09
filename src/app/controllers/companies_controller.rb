class CompaniesController < ApplicationController

  def index
    @companies = Company.filter(params.slice(:starts_with))
    render json: @companies, status: :ok
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      render json: @company, status: :created
    else
      render json: { errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private
  def company_params
    params.permit(:name, :city, :country, :email_domain)
  end
end
