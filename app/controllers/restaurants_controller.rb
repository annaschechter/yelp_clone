class RestaurantsController < ApplicationController

	# before_action :authenticate_user!, :except => [:index, :show]

	def index
		@restaurants = Restaurant.all
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		if current_user
			@restaurant = Restaurant.new(params[:restaurant].permit(:name, :description, :image))
			@restaurant.user_id = current_user.id 
		end

		if @restaurant.save
			redirect_to restaurants_path
		else
			render 'new'
		end
	end

	def show
		@restaurant = Restaurant.find(params[:id])
	end

	def edit
		@restaurant = Restaurant.find(params[:id])
		@user = User.find(@restaurant.user_id)
	end

	def update
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(params[:restaurant].permit(:name))
		redirect_to '/restaurants'
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		if @restaurant.user_id == current_user.id
			@restaurant.destroy
			redirect_to '/restaurants'
			flash[:notice] = "Restaurant deleted successfully"
		else
			redirect_to '/restaurants'
			flash[:error] = "You can only delete restaurant if you've created it"
		end
	end
end
