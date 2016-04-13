class Api::V1::ScheduleheadersController < ApplicationController


	respond_to :json

	before_action :authenticate_with_token!
	before_action :carga_datos, :only => [:create, :addBody] 

	def create
		byebug
		if (validDate(@schedule_data_input[:date_ini].to_date) && validDate(@schedule_data_input[:date_end].to_date) &&
			validTime(@schedule_data_input[:time_ini].to_time) && validTime(@schedule_data_input[:time_end].to_time)) then
			if dataOk then
				if !overlap(1,0,1,0) then
					ActiveRecord::Base.transaction do
						schedule_bodies = Schedulebody.new
						time_ini_format = time_ini_format = Time.new('2000','1','1',(@schedule_data_input[:time_ini].to_time).hour,(@schedule_data_input[:time_ini].to_time).min) 
						time_end_format = Time.new('2000','1','1',(@schedule_data_input[:time_end].to_time).hour,(@schedule_data_input[:time_end].to_time).min) 
						schedule_bodies.time_ini = time_ini_format
						schedule_bodies.time_end = time_end_format
						schedule_bodies.su= @schedule_data_input[:su]
						schedule_bodies.mo= @schedule_data_input[:mo]
						schedule_bodies.tu= @schedule_data_input[:tu]
						schedule_bodies.we= @schedule_data_input[:we]
						schedule_bodies.th= @schedule_data_input[:th]
						schedule_bodies.fr= @schedule_data_input[:fr]
						schedule_bodies.sa= @schedule_data_input[:sa]
						schedule_bodies.scheduleheader=Scheduleheader.new
						schedule_bodies.scheduleheader.branchoffice_id=@schedule_data_input[:branchoffice_id]
						schedule_bodies.scheduleheader.room_id=@schedule_data_input[:room_id]
						schedule_bodies.scheduleheader.activity_id=@schedule_data_input[:activity_id]
						schedule_bodies.scheduleheader.resourcetype_id=@schedule_data_input[:resourcetype_id]
						schedule_bodies.scheduleheader.date_ini=@schedule_data_input[:date_ini].to_date
						schedule_bodies.scheduleheader.date_end=@schedule_data_input[:date_end].to_date
						schedule_bodies.scheduleheader.capacity=@schedule_data_input[:capacity]
						if schedule_bodies.save! then
							if (@schedule_data_input[:resourcetype_id] != nil) && (@schedule_data_input[:resourcetype_id].to_i > 0) then
								resourcetype_data = Resourcetype.where('id = ?',@schedule_data_input[:resourcetype_id])
								capacity_resource = resourcetype_data[0]['capacity_resource']
								resource_name = resourcetype_data[0]['name']	
								if capacity_resource > 0 then
									number_resource = ((@schedule_data_input[:capacity]).to_i/capacity_resource).floor
									resource = Array.new
									for i in 0..(number_resource -1)
										name = (schedule_bodies.scheduleheader_id).to_s + '_' + resource_name  + '_'+ (i +1).to_s
										resource[i] = {:name =>name, :resourcetype_id => @schedule_data_input[:resourcetype_id].to_i, :scheduleheader_id => schedule_bodies.scheduleheader_id, :enabled => true}
									end
									if Resource.create!(resource) then
										render json: {data: schedule_bodies}, status: 201
									else
										render json: {}, status: 422
									end
								else
									render json: {errors: I18n.t(:invalid_data) }, status: 400
								end
							else
								render json: {data: schedule_bodies}, status: 201
							end
						else
							render json: {}, status: 422
						end
					end				
				else
					render json: {data: @overlap_data}, status: 210
				end
			else
				render json: {errors: I18n.t(:invalid_data) }, status: 400
			end
		else
			render json: {errors: I18n.t(:invalid_data) }, status: 400
		end
		
	end 

	def addBody
		if (validDate(@schedule_data_input[:date_ini].to_date) && validDate(@schedule_data_input[:date_end].to_date) &&
			validTime(@schedule_data_input[:time_ini].to_time) && validTime(@schedule_data_input[:time_end].to_time)) then
			if dataOk then
				if !overlap(1,0,1,0) then
					schedule_bodies = Schedulebody.new
					time_ini_format = time_ini_format = Time.new('2000','1','1',(@schedule_data_input[:time_ini].to_time).hour,(@schedule_data_input[:time_ini].to_time).min) 
					time_end_format = Time.new('2000','1','1',(@schedule_data_input[:time_end].to_time).hour,(@schedule_data_input[:time_end].to_time).min) 
					schedule_bodies.time_ini = time_ini_format
					schedule_bodies.time_end = time_end_format
					schedule_bodies.su= @schedule_data_input[:su]
					schedule_bodies.mo= @schedule_data_input[:mo]
					schedule_bodies.tu= @schedule_data_input[:tu]
					schedule_bodies.we= @schedule_data_input[:we]
					schedule_bodies.th= @schedule_data_input[:th]
					schedule_bodies.fr= @schedule_data_input[:fr]
					schedule_bodies.sa= @schedule_data_input[:sa]
					schedule_bodies.scheduleheader_id=@schedule_data_input[:scheduleheader_id]
					if schedule_bodies.save! then
						render json: {data: schedule_bodies}, status: 201
					else
						render json: {}, status: 422
					end			
				else
					render json: {data: @overlap_data}, status: 210
				end
			else
				render json: {errors: I18n.t(:invalid_data) }, status: 400
			end
		else
			render json: {errors: I18n.t(:invalid_data) }, status: 400
		end
		
	end

	def show
		schedules = Scheduleheader.includes(:schedulebody).where('scheduleheaders.branchoffice_id = ?',params[:id]).map do|h| 
			{
				id: h.id, 
				activity_name: h.activity.name, 
				room_name: h.room.name, 
				date_ini: h.date_ini, 
				date_end: h.date_end, 
				resourcetype_name: h.resourcetype_id, 
				capacity: h.capacity, 
				enabled: h.enabled,
				body: h.schedulebody.map do|b| 
					{
						id: b.id, 
						time_ini: b.time_ini, 
						time_end: b.time_end, 
						sunday: b.su, 
						monday: b.mo, 
						tuesday: b.tu, 
						wednesday: b.we, 
						thursday: b.th, 
						friday: b.fr, 
						saturday: b.sa,
						enabled: b.enabled
					}
				end
			}
		end

		if !schedules.blank? then
			render json: {data: schedules}, status: 200
		else
			render json: {data: {}}, status: 204
		end

	end

	private

		def carga_datos
			if (scheduleheaders_params[:scheduleheader_id]=='') || ((scheduleheaders_params[:scheduleheader_id]).to_i <=0 ) then
				@schedule_data_input = {
					id: scheduleheaders_params[:id], 
					branchoffice_id: scheduleheaders_params[:branchoffice_id], 
					date_ini: scheduleheaders_params[:date_ini], 
					date_end: scheduleheaders_params[:date_end], 
					room_id:  scheduleheaders_params[:room_id], 
					activity_id: scheduleheaders_params[:activity_id], 
					capacity: scheduleheaders_params[:capacity], 
					resourcetype_id: scheduleheaders_params[:resourcetype_id], 
					scheduleheader_id: scheduleheaders_params[:scheduleheader_id]
				}

			else
				header = Scheduleheader.find(scheduleheaders_params[:scheduleheader_id])
				byebug
				@schedule_data_input = {
					branchoffice_id: header.branchoffice_id,
					date_ini: header.date_ini,
					date_end: header.date_end,
					room_id: header.room_id,
					activity_id: header.activity_id,
					capacity: header.capacity,
					resourcetype_id: header.resourcetype_id,
					scheduleheader_id: header.id

				} 

			end
			@schedule_data_input[:time_ini] = scheduleheaders_params[:time_ini]
			@schedule_data_input[:time_end] = scheduleheaders_params[:time_end]
			@schedule_data_input[:su] = scheduleheaders_params[:su]
			@schedule_data_input[:mo] = scheduleheaders_params[:mo]
			@schedule_data_input[:tu] = scheduleheaders_params[:tu] 
			@schedule_data_input[:we] = scheduleheaders_params[:we]
			@schedule_data_input[:th] = scheduleheaders_params[:th]
			@schedule_data_input[:fr] = scheduleheaders_params[:fr]
			@schedule_data_input[:sa] = scheduleheaders_params[:sa]

		end

		

		def valid_date(fecha)
			return Date.valid_date?(fecha.year,fecha.month,fecha.day)
		end

		def valid_time(hora)
			return ((0 <=hora.hour <=23) && (0<=hora.min<=59))
		end

		def overlap (allheaders, header_id, allbodies,body_id)
			if allheaders == 1 then
				headers = Scheduleheader.where('branchoffice_id = ? and room_id = ? and date_end >= ?', @schedule_data_input[:branchoffice_id], @schedule_data_input[:room_id], @schedule_data_input[:date_ini].to_date)
			else
				headers = Scheduleheader.where('branchoffice_id = ? and room_id = ? and date_end >= ? and id != ?', @schedule_data_input[:branchoffice_id], @schedule_data_input[:room_id], @schedule_data_input[:date_ini].to_date, header_id)
			end
			if !headers.blank? then
				headers_count = 0
				headers_length = headers.length
				overlap = false
				while ((headers_count <= headers.length - 1) && (!overlap)) do
					date_ini = (headers[headers_count]['date_ini']).to_date
					date_end = (headers[headers_count]['date_end']).to_date
					overlapDate = false
					overlapTime =false
					overlapDay = false
					overlapDate = overlap_date(date_ini, date_end, @schedule_data_input[:date_ini].to_date, @schedule_data_input[:date_end].to_date)
					if overlapDate then
						time_ini_format = Time.new('2000','1','1',(@schedule_data_input[:time_ini].to_time).hour,(@schedule_data_input[:time_ini].to_time).min) 
						if allbodies == 1 then
							bodies = Schedulebody.where('scheduleheader_id = ? and time_end >= ?', headers[headers_count]['id'], time_ini_format)
						else
							bodies = Schedulebody.where('scheduleheader_id = ? and time_end >= ? and id != ?', headers[headers_count]['id'], time_ini_format, body_id)
						end
						bodies_count = 0
						bodies_length = bodies.length
						while ((bodies_count <= bodies_length - 1) && (!overlapDay)) do
							time_ini = bodies[bodies_count]['time_ini']
							time_end = bodies[bodies_count]['time_end']
							overlapTime=overlap_time(time_ini, time_end, @schedule_data_input[:time_ini].to_time, @schedule_data_input[:time_end].to_time)
							if overlapTime then
								su = bodies[bodies_count]['su']
								mo = bodies[bodies_count]['mo']
								tu = bodies[bodies_count]['tu']
								we = bodies[bodies_count]['we']
								th = bodies[bodies_count]['th']
								fr = bodies[bodies_count]['fr']
								sa = bodies[bodies_count]['sa']
								new_su = @schedule_data_input[:su]
								new_mo = @schedule_data_input[:mo]
								new_tu = @schedule_data_input[:tu]
								new_we = @schedule_data_input[:we]
								new_th = @schedule_data_input[:th]
								new_fr = @schedule_data_input[:fr]
								new_sa = @schedule_data_input[:sa]
								overlapDay = overlap_day(su,mo,tu,we,th,fr,sa,new_su,new_mo,new_tu,new_we,new_th,new_fr,new_sa)
							end
							bodies_count = bodies_count + 1
						end
					end
					overlap = overlapDate && overlapTime && overlapDay
					if overlap then
						@overlap_data = 
						{
							id: headers[headers_count]['id'], 
							room_name: headers[headers_count]['room.name'], 
							activity_name: headers[headers_count]['activity.name'], 
							date_ini: headers[headers_count]['date_ini'], 
							date_end: headers[headers_count]['date_end']
						}
					else
						headers_count = headers_count + 1
					end
					
				end
			else
				overlap = false
			end

			return overlap

		end

		def overlap_date (date_ini, date_end, new_date_ini, new_date_end)
			return (((date_ini - new_date_end).to_i) * ((new_date_ini - date_end).to_i)) >= 0
		end

		def overlap_time (time_ini, time_end, new_time_ini, new_time_end)
			time_ini = Time.new('2000','1','1',time_ini.hour,time_ini.min)
			time_end = Time.new('2000','1','1',time_end.hour,time_end.min)
			new_time_ini = Time.new('2000','1','1',new_time_ini.hour,new_time_ini.min)
			new_time_end= Time.new('2000','1','1',new_time_end.hour,new_time_end.min)
			return (((time_ini - new_time_end).to_i) * ((new_time_ini - time_end).to_i)) >= 0
		end

		def overlap_day (su,mo,tu,we,th,fr,sa,new_su,new_mo,new_tu,new_we,new_th,new_fr,new_sa)
			return ((su ==new_su)||(mo==new_mo)||(tu==new_tu)||(we==new_we)||(th==new_th)||(fr==new_fr)||(sa==new_sa))
		end 

		def scheduleheaders_params
			params.require(:scheduleheader).permit(:id, :branchoffice_id, :date_ini, :date_end, :time_ini, :time_end, :room_id, :activity_id, :su, :mo, :tu, :we, :th, :fr, :sa, :capacity, :resourcetype_id, :scheduleheader_id)
		end

		def validDate (date)
			return Date.valid_date?(date.year, date.month, date.day)
		end
		def validTime (time)
			return ((time.hour >= 0) && (time.hour <=23) && (time.min>=0) && (time.min <= 59))
		end
		def dataOk
			if (@schedule_data_input[:date_ini] != "") && (@schedule_data_input[:date_end] != "") && (@schedule_data_input[:time_ini] !="")  && (@schedule_data_input[:time_end] != "") then
				dateOk = @schedule_data_input[:date_ini].to_date <= @schedule_data_input[:date_end].to_date
				time_ini=@schedule_data_input[:time_ini].to_time
				time_end=@schedule_data_input[:time_end].to_time
				time_ini_format = Time.new('2000','1','1',time_ini.hour,time_ini.min)
				time_end_format = Time.new('2000','1','1',time_end.hour,time_end.min)
				timeOk=time_ini_format<=time_end_format
			else
				dateOk = false
				timeOk = false
			end
			return dateOk&&timeOk 
		end

		def datachanged (changedheader, header_id, changedbody,body_id, data)
			datachanged = {}
			if changedheader then
				@oldheader = Scheduleheader.find(header_id)
				if !oldheader.blank? then
					datachanged[scheduleheader_id]=0
					if data[:branchoffice_id] != oldheader.branchoffice_id then
						datachanged[:branchoffice_id]=1
					else
						datachanged[:branchofice_id]=0
					end
					if data[:room_id] != oldheader.room_id then
						datachanged[:room_id]=1
					else
						datachanged[:room_id]=0
					end 
					if data[:activity_id] != oldheader.activity_id then
						datachanged[:activity_id]=1
					else
						datachanged[:activity_id]=0
					end
					if data[:resourcetype_id] != oldheader.resourcetype_id then
						datachanged[:resourcetype_id]=1
					else
						datachanged[:resourcetype_id]=0
					end
					if data[:date_ini] != oldheader.date_id then
						datachanged[:date_ini]=1
					else
						datachanged[:date_ini]=0
					end
					if data[:date_end] != oldheader.date_end then
						datachanged[:date_end]=1
					else
						datachanged[:date_end]=0
					end
					if data[:capacity] != oldheader.capacity then
						datachanged[:capacity]=1
					else
						datachanged[:capacity]=0
					end
				else
					datachanged[:scheduleheader_id]=1
					datachanged[:branchoffice_id]=1
					datachanged[:room_id]=1
					datachanged[:activity_id]=1
					datachanged[:resourcetype_id]=1
					datachanged[:date_ini]=1
					datachanged[:date_end]=1
					datachanged[:capacity]=1
				end
			else
				datachanged[:scheduleheader_id]=0
				datachanged[:branchoffice_id]=0
				datachanged[:room_id]=0
				datachanged[:activity_id]=0
				datachanged[:resourcetype_id]=0
				datachanged[:date_ini]=0
				datachanged[:date_end]=0
				datachanged[:capacity]=0
			end 

			if changedbody then
				@oldbody = Schedulebody.find(body_id)
				if !oldbody.blank? then
					datachanged[:schedulebody_id]=0
					oldbody_time_ini_format=Time.new('2000','1','1',oldbody.time_ini.hour,oldbody.time_ini.min)
					data_time_ini_format=Time.new('2000','1','1',data[:time_ini].hour,data[:time_ini].min)
					if oldbody_time_ini_format != data_time_ini_format then
						datachanged[:time_ini]=1
					else
						datachanged[:time_ini]=0
					end
					oldbody_time_end_format=Time.new('2000','1','1',oldbody.time_end.hour,oldbody.time_end.min)
					data_time_end_format=Time.new('2000','1','1',data[:time_end].hour,data[:time_end].min)
					if oldbody_time_end_format != data_time_end_format then
						datachanged[:time_end]=1
					else
						datachanged[:time_end]=0
					end
					if oldbody.su != data[:su] then
						datachanged[:su]=1
					else
						datachanged[:su]=0
					end
					if oldbody.su != data[:mo] then
						datachanged[:mo]=1
					else
						datachanged[:mo]=0
					end
					if oldbody.su != data[:tu] then
						datachanged[:tu]=1
					else
						datachanged[:tu]=0
					end
					if oldbody.su != data[:we] then
						datachanged[:we]=1
					else
						datachanged[:we]=0
					end
					if oldbody.su != data[:th] then
						datachanged[:th]=1
					else
						datachanged[:th]=0
					end
					if oldbody.su != data[:fr] then
						datachanged[:fr]=1
					else
						datachanged[:fr]=0
					end
					if oldbody.su != data[:sa] then
						datachanged[:sa]=1
					else
						datachanged[:sa]=0
					end
				else
					datachanged[:schedulebody_id]=1
					datachanged[:time_ini]=1
					datachanged[:time_end]=1
					datachanged[:su]=1
					datachangde[:mo]=1
					datachanged[:tu]=1
					datachanged[:we]=1
					datachanged[:th]=1
					datachanged[:fr]=1
					datachanged[:sa]=1
				end
			else
				datachanged[:schedulebody_id]=0
				datachanged[:time_ini]=0
				datachanged[:time_end]=0
				datachanged[:su]=0
				datachangde[:mo]=0
				datachanged[:tu]=0
				datachanged[:we]=0
				datachanged[:th]=0
				datachanged[:fr]=0
				datachanged[:sa]=0

			end

			return datachanged
		end

		def bookoutofdayrange(date_ini, date_end, scheduleheader_id)
			books = Book.select("id").where('scheduleheader_id = ? and date_ini >= ? and date_end <= ?', scheduleheader_id, date_ini, date_end)
			return books
		end

		def bookoutofhourrange(date_ini, time_ini, time_end,schedulebody_id)
			time_ini_format = Time.new('2000','1','1',time_ini.hour,time_ini.min)
			time_end_format = Time.new('2000','1','1',time_end.hour,time_end.min)
			books = Book.select("id").where('schedulebody_id = ? and time_ini >= ? and time_end <= ? and date_ini >= ?', schedulebody_id, time_ini_format, time_end_format, date_ini)
		end

		def bookoutofweekdayrange(date_ini,date_end,schedulebody_id,daysofweek)
			my_days=daysofweek
			days=(date_ini..date_end).to_a.select{|d| my_days.include?(d.wday)}
			if days.size >= 0 then
				books = Book.select("id").where('schedulebody_id = ?', schedulebody_id).where(date_ini: days)
			else
				books = Array.new
			end
		end

		def bookoutofresourcerange(schedulebody_id,resources,date_ini)
			books = Book.where('schedulebody_id = ?, date_ini >= ?', schedulebody_id,date_ini).where(resource_id: resources)
			return books
		end

		def enabledisableresources(resources_id,enabled)
			#Devuelve el número de filas actualizas; si no actualiza ninguna devuelve 0
			return Resource.where(id: resources_id).update_all(:enabled => enabled)
		end

		def enabledisblebooks(books_id,estado)
			return Book.where(id: books_id).update_all( :bookstatus_id => estado)
		end

end