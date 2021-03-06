module  V2
	class SolarSystemsController < ApplicationController

		def index

			case request.env['PATH_INFO']
			when "/solarsystem"
				if params[:api_key] == 'demo'
					render json: { status: Message.successful_request, version: 'demo', data: Planet.all.select(:id,:name, :moons)}
				elsif params[:api_key] && User.exists?(:api_key => params[:api_key])
					render json: { status: Message.successful_request, version: '2.0', data: Planet.all.select(:id,:name,:distance_from_sun, :mass, :average_temperature, :volume, :diameter, :orbital_period, :moons, :length_of_day, :gravity, :major_gases)}
				else
					json_response({ Message: 'Invalid API KEY'})
				end
			when "/mercury"
				show('mercury')
			when "/venus"
				show('venus')
			when "/earth"
				show('earth')
			when "/mars"
				show('mars')
			when "/jupiter"
				show('jupiter')
			when "/saturn"
				show('saturn')
			when "/uranus"
				show('uranus')
			when "/neptune"
				show('neptune')
			end
		end

		def show(planet)
			if params[:api_key] == 'demo'
				render json: { status: Message.successful_request, version: 'demo', data: Planet.all.where("name ILIKE ?",planet).select(:id,:name, :moons)}
			elsif params[:api_key] && User.exists?(:api_key => params[:api_key])
				render json: { status: Message.successful_request, version: '2.0', data: Planet.all.where("name ILIKE ?",planet).select(:id,:name,:distance_from_sun, :mass, :average_temperature, :volume, :diameter, :orbital_period, :moons, :length_of_day, :gravity, :major_gases)}

			else
				json_response({ Message: 'Invalid API KEY'})
			end
		end



	end
end