class Api::V1::CompaniesController < ApplicationController

	respond_to :json

	before_action :authenticate_with_token!

	def create
		new_company=Company.new 
		new_company.nombre = companies_params[:name]
		new_company.user_id = current_user.id
		if new_company.save then
			render json: {data: {company_id: new_company.id, company_name: new_company.nombre, branches: []}}, status: 201
		else
			render json: {errors: new_company.errors}, status: 422
		end
	end

	def show
		companias=Company.select("id,nombre").all
		if !companias.blank? then
			render json: {data:companias}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def showByUser
		companias=Company.select("id,nombre").find_by_user_id(params[:id])
		if !companias.blank? then
			render json: {data:companias}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def showByCompany
		compania=Company.select("id,nombre").find(params[:id])
		if !compania.blank? then
			render json: {company:compania}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def update
		compania = Company.find(companies_params[:id])
		if !compania.blank? then
			compania.name=companies_params[:name]
			if compania.save then
				render json: {data: {company_id: compania.id, company_name: compania.name}}, status: 200
			else
				render json: {error: compania.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end
	end

	def destroy
		compania = Company.find(companies_params[:id])
		if !compania.blank? then
			if compania.destroy then
				render json: {data: {}}, status:204
			else
				render json: {error: compania.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end

	end
	def types
		tipos = CompanyType.select('id,tipo').all
		render json: {company_types: tipos}
	end


	private

		def companies_params
			params.require(:company).permit(:name, :id)
		end
end 