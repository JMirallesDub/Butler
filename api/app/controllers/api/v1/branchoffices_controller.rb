class Api::V1::BranchofficesController < ApplicationController


	respond_to :json

	before_action :authenticate_with_token!

	def create
		branch=Branchoffice.new
		branch.name=branchoffices_params[:name]
		branch.direccion = branchoffices_params[:address]
		branch.company_id=branchoffices_params[:company]
		branch.user_id=current_user.id
		branch.company_type_id=branchoffices_params[:type]
		branch.image=branchoffices_params[:image]
		if branch.save
			newBranch={branch_id: branch.id, branch_name: branch.name, branch_address: branch.direccion, company_id: branch.company_id, branch_image_url: "http://localhost:3000" + branch.image.url(:medium)}
			render json: {data: newBranch}, status: 201
		else
			render json: {error: branch.errors}, status: 422
		end
	end

	def show
		branch = Company.includes(:branchoffice).map do |i| 
			{
				company_id: i.id, 
				company_name: i.nombre, 
				branches: i.branchoffice.map do |branch| 
					{
						branch_id: branch.id,
						branch_name: branch.name, 
						branch_address: branch.direccion,
						branch_image_url: "http://localhost:3000" + branch.image.url(:medium)
						
					} 
				end
			} 
		end
		if !branch.blank? then
			render json: {data: branch}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def showByUser

		branch = Company.includes(:branchoffice).where('companies.user_id = ? OR branchoffices.user_id = ?', params[:id], params[:id]).order('branchoffices.company_id').map do|c|
		 	{
		 		company_id: c.id, 
		 		company_name: c.nombre, 
		 		company_user_id: c.user_id, 
		 		branches: c.branchoffice.map do |b| 
		 			{
		 				branch_id: b.id, 
		 				branch_name: b.name, 
		 				branch_user_id: b.user_id,
		 				branch_address: b.direccion,
		 				branch_image_url: "http://localhost:3000" + b.image.url(:medium)
		 			}
		 		end
		 	}
		end
		if !branch.blank? then
			render json: {data: branch}, status: 200
		else
			render json: {data: {}}, status: 204
		end

	end

	def showByCompany
		branch = Company.includes(:branchoffice).where(:id => params[:id]).map do |c| 
			{
				company_id: c.id, 
				company_name: c.nombre, 
				branches: c.branchoffice.map do |b| 
					{
						branch_id: b.id, 
						branch_name: b.name, 
						branch_address: b.direccion,
						branch_image_url: "http://localhost:3000" + b.image.url(:medium)
					}
				end
			}
		end

		if !branch.blank? then
			render json: {data: branch}, status: 200
		else
			render json: {data: {}}, status: 204
		end

	end

	def showByActivityType
		branch = Company.includes(:branchoffice).where(branchoffices: {:company_type_id => params[:id]}).map do |c| 
			{
				company_id: c.id, 
				company_name: c.nombre, 
				branches: c.branchoffice. map do |b| 
					{
						branch_id: b.id, 
						branch_name: b.name, 
						branch_address: b.direccion,
						branch_image_url: "http://localhost:3000" + b.image.url(:medium)
					}
				end
			}
		end

		if !branch.blank? then
			render json: {data: branch}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def update
		branch = Branchoffice.find(branchoffices_params[:id])
		if !branch.blank? then
			branch.name=branchoffices_params[:name]
			branch.direccion = branchoffices_params[:address]
			branch.company_type_id=branchoffices_params[:type]
			branch.image = brachoffices_params[:image]
			if branch.save then
				render json: {data: {branch_id: branch.id, branch_name: branch.name, branch_address: branch.direccion, branch_type: branch.company_type_id}}, status: 200
			else
				render json: {error: branch.errors}, status: 422
			end
		else
			render json: {error: I18n.t(:data_not_found)}, status: 404
		end
	end

	def destroy
		branch = Branchoffice.find(branchoffices_params[:id])
		if !branch.blank? then
			if compania.destroy then
				render json: {data: {}}, status:204
			else
				render json: {error: branch.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end

	end

	
	private

		def branchoffices_params
			params.require(:branchoffices).permit(:name, :address, :postalcode, :company, :user, :type, :id, :image)
		end
end