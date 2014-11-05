class ReviewsController < ApplicationController

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
		
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		review = @restaurant.reviews.create(params[:review].permit(:thoughts, :rating))
		review.user_id = current_user.id
		if review.save
			redirect_to restaurants_path
			flash[:notice] = 'The restaurant was added successfully'
		else
			redirect_to restaurants_path
			flash[:error] = 'You have already reviewed this restaurant'
		end
	end

	def destroy
		@review = Review.find(params[:id])
		if @review.user_id == current_user.id
			@review.destroy
			redirect_to '/restaurants'
			flash[:notice] = "Review deleted successfully"
		else
			redirect_to '/restaurants'
			flash[:error] = "You can only delete review if you've created it"
		end
	end
end
