require 'rails_helper'

describe 'restaurant' do

	def sign_up_add_restaurant
		visit '/'
		click_link 'Sign up'
		fill_in 'Email', with: "anna@example.com"
		fill_in 'Password', with: "testtest"
		fill_in 'Password confirmation', with: 'testtest'
		click_button 'Sign up'		
		click_link 'Add restaurant'
		fill_in 'Name', with: 'KFC'
		click_button 'Create Restaurant'
	end

	context 'no restaurants have been added' do

		it 'should display a prompt to add a restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants'
			expect(page).to have_link 'Add restaurant'
		end
	end

	it 'should only allow logged in users to add restaurant' do
		visit '/'
		click_link 'Add restaurant'
		expect(page).not_to have_css 'form'
		expect(page).to have_content 'You need to be logged in to add restaurants!'
	end

	context 'restaurants have been added' do
		before do 
			sign_up_add_restaurant
		end

		it 'should display restaurants' do
			visit '/restaurants'
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurants yet')
		end
	end

	context 'viewing restaurants' do
		before do 
			sign_up_add_restaurant
		end

		it 'lets a user view a restaurant' do
			@kfc = Restaurant.find_by name: 'KFC'
			visit '/restaurants'
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{@kfc.id}"
		end
	end

	context 'editing restaurants' do

		it 'lets a user edit a restaurant' do
			sign_up_add_restaurant
			visit '/restaurants'
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end

		it 'only allows users to edit restaurants which they\'ve created' do
			sign_up_add_restaurant
			click_link 'Sign out'
			visit '/'
			click_link 'Edit KFC'
			expect(page).not_to have_css 'form'
			expect(page).to have_content "You cannot edit this restaurant because you did not add it!"
		end
	end


	describe 'creating restaurants' do

		before do 
			visit '/'
			click_link 'Sign up'
			fill_in 'Email', with: "test@example.com"
			fill_in 'Password', with: "testtest"
			fill_in 'Password confirmation', with: 'testtest'
			click_button 'Sign up'
		end

		it 'prompts user to fill out a form, then displays the new restaurant' do
			visit '/restaurants'
			click_link 'Add restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		context 'an invalid restaurant' do
			it 'does not let you submit a name that is too short' do
				visit '/restaurants'
				click_link 'Add restaurant'
				fill_in 'Name', with: 'kf'
				click_button 'Create Restaurant'
				expect(page).not_to have_css 'h2', text: 'kf'
				expect(page).to have_content 'error'
			end

		end
	end

	describe 'deleting restaurants' do

		before do 
			sign_up_add_restaurant
		end

		it 'removes a restaurant when a user clicks a delete link' do
			visit '/restaurants'
			click_link 'Delete KFC'
			expect(page).not_to have_content "KFC"
			expect(page).to have_content 'Restaurant deleted successfully'
		end

	end

end