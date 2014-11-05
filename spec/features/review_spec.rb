require 'rails_helper'

describe 'reviewing' do

	def leave_review
		visit '/restaurants'
		click_link 'Review KFC'
		fill_in "Thoughts", with: "so so "
		select '3', from: 'Rating'
		click_button 'Leave Review'
	end


	def sign_up_add_restaurant(name, rest)
		visit '/'
		click_link 'Sign up'
		fill_in 'Email', with: name+"@example.com"
		fill_in 'Password', with: "testtest"
		fill_in 'Password confirmation', with: 'testtest'
		click_button 'Sign up'		
		click_link 'Add restaurant'
		fill_in 'Name', with: rest
		click_button 'Create Restaurant'
	end

	before do
		sign_up_add_restaurant("anna", "KFC")
		leave_review
	end

	it 'allows users to leave a review using a form' do
		expect(current_path).to eq '/restaurants'
		expect(page).to have_content('so so')
	end

	it 'allows users to leave only one review per restaurant' do
		visit '/'
		click_link 'Review KFC'
		fill_in "Thoughts", with: "so so "
		select '3', from: 'Rating'
		click_button 'Leave Review'
		expect(page).not_to have_content 'The restaurant was added successfully'
		expect(page).to have_content 'You have already reviewed this restaurant'
	end

end