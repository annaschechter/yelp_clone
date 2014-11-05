class ReviewsController < ApplicationController

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
		
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		review = @restaurant.reviews.create(params[:review].permit(:thoughts, :rating))
		if review.save
			redirect_to restaurants_path
			flash[:notice] = 'The restaurant was added successfully'
		else
			redirect_to restaurants_path
			flash[:error] = 'You have already reviewed this restaurant'
		end
	end
end
