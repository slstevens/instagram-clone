require 'rails_helper'

describe 'photos' do
	context 'no photos have been added' do
		it 'should display a prompt to add a photo' do
			visit '/photos'
			expect(page).to have_content 'No photos'
			expect(page).to have_link 'Add a photo'
		end
	end

	context 'photos have been added' do
		before do
			Photo.create(title: 'Hello World')
		end

		it 'should display photos' do
			visit '/photos'
			expect(page).to have_content('Hello World')
			expect(page).not_to have_content('No photos yet')
		end
	end
end

describe 'creating photos' do

	before do
		test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
		login_as test_user
	end

	it 'prompts user to fill out a form, then displays the new photo' do
		visit '/photos'
		click_link 'Add a photo'
		fill_in 'Title', with: 'Hello World'
		click_button 'Create Photo'
		expect(page).to have_content 'Hello World'
		expect(current_path).to eq '/photos'
	end
end

describe 'editing photos' do

	before do
		Photo.create(title:'Hello World Before Edit')
		test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
		login_as test_user
	end

	it 'lets a user edit a Photo' do
		visit '/photos'
		click_link 'Edit'
		fill_in 'Title', with: 'Hello World'
		click_button 'Update Photo'
		expect(page).to have_content 'Hello World'
		expect(current_path).to eq '/photos'
	end

end

describe 'deleting photos' do

	before do
		Photo.create(title:'Hello World')
		test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
		login_as test_user
	end

	it "removes a photo when a user clicks a delete link" do
		visit '/photos'
		click_link 'Delete'
		expect(page).not_to have_content 'Hello World'
		expect(page).to have_content 'Photo deleted successfully'
	end

end
