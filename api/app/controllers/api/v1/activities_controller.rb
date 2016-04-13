class Api::V1::ActivitiesController < ApplicationController


	respond_to :json

	before_action :authenticate_with_token!


	def create
		act=Activity.new(activities_params)
		if act.save then
			render json: {data: {activity_id: act.id, activity_name: act.name, activity_image_url: "http://localhost:3000" + act.image.url(:medium)}}, status: 201
		else
			render json: {error: act.errors}, status: 422
		end
	end

	def showByRoom
		rooms = Activity.includes(:activitiesofroom).where(activitiesofrooms: {:room_id => params[:id]}).map do |a| 
			{
				activity_id: a.id, 
				activity_name: a.name,
				activity_image_url: "http://localhost:3000" + a.image.url(:medium)
			}
		end
		if !rooms.blank? then
			render json: {data: rooms}, status: 200
		else
			render json: {data: {}}, status: 204
		end

	end

	def showByBranch
		branch=Activity.includes(:branchoffice).where(branchoffices: {:id => params[:id]}).map do |a| 
			{
				activity_id: a.id, 
				activity_name: a.name,
				activity_image_url: "http://localhost:3000" + a.image.url(:medium)
			}
		end
		if !branch.blank? then
			render json: {data: branch}, status: 200
		else
			render json: {data:{}}, status: 204
		end
	end

	def update
		act = Activity.find(activities_params[:id])
		if !act.blank? then
			act.name=activities_params[:name]
			act.branchoffice_id=activities_params[:branchoffice_id]
			act.image= activities_params[:image]
			if act.save then
				render json: {data: act}, status: 200
			else
				render json: {error: act.errors}, status: 422
			end

		else
			render json: {data: {}}, status: 204
		end
	end

	def destroy
		act = Activity.find(activities_params[:id])
		if !act.blank? then
			if act.destroy then
				render json: {data: {}}, status:204
			else
				render json: {error: act.errors}, status: 422
			end
		else
			render json: {data: {}}, status: 204
		end
	end
	private

		def activities_params
			params.require(:activities).permit(:name, :branchoffice_id, :id, :image)
		end

end