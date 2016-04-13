class Api::V1::RoomsController < ApplicationController
	
	respond_to :json

	#before_action :authenticate_with_token!

	def create
		sala=Room.new(rooms_params)
		if sala.save then
			render json: {id: sala.id, name: sala.name}, status: 200
		else
			render json: {errors: sala.errors}, status: 422
		end
	end

	def show
		salas=Room.select("id,name").find_by_id(params[:id])
		if !salas.blank? then
			render json: {data: salas}, status: 200
		else
			render json: {data: {}}, status: 204
		end
	end

	def showByBranch
		salas=Room.select("id,name").where('branchoffice_id = ?',params[:id])
		if !salas.blank? then
			render json: {data: salas}, status: 200
		else
			render json: {data: {}}, status: 204

		end 
	end

	def update
		sala=Room.find_by_id(rooms_params[:id])
		if !sala.blank? then
			sala.branchoffice_id=rooms_params[:id]
			if sala.save then
				render json: {data: sala}, status:200
			else
				render json: {error: sala.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end
	end

	def destroy
		room = Room.find(rooms_params[:id])
		if !room.blank? then
			if room.destroy then
				render json: {data: {}}, status:204
			else
				render json: {error: room.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end
	end
	def disableroom
		response = enabledisableroom([63,64], 0)
		render json: response
	end
	def enableroom
		enabledisableroom([63,64], 1)
	end

	private

		def rooms_params
			params.require(:rooms).permit(:name, :id, :branchoffice_id)
		end

		def enabledisableroom(rooms_ids, action)
			if rooms_ids.length > 0 then
				roomtoupdate=Room.where(id: rooms_ids)
				begin
					roomtoupdate.transaction do
						roomtoupdate.each do |r|
							r.enabled = action
							r.save!
						end
					end
					response = {data: {}, status: 200}

				rescue ActiveRecord::RecordInvalid => invalid
					response = {data: invalid.record.errors, status: 422}
				end
			else
				response = {data: {}, status: 204}
			end
			return response
		end
end