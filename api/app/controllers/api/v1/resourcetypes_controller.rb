class Api::V1::ResourcetypesController < ApplicationController

	respond_to :json

	before_action :authenticate_with_token!

	def show
		resources = Resourcetype.select("id, name").order("name asc")
		render json: {data: resources}, status:200
	end

end