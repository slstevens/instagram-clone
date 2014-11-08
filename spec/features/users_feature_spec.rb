require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
  end

  it "should not see 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end
end

context "user signed in on the homepage" do

  before do
    visit('/')
    test_user = User.create(email: "sean@makers.com", password: "12345678", password_confirmation: "12345678")
    login_as test_user
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end

  it "should be able to edit restaurants which they've created" do
    add_restaurant
    visit '/photos'
    click_link 'Edit'
    fill_in 'Title', with: 'Hello World2'
    click_button 'Update Photo'
    expect(page).to have_content 'Hello World2'
    expect(current_path).to eq '/photos'
  end

end

  def add_restaurant
      visit '/photos'
      click_link 'Add a photo'
      fill_in 'Title', with: 'Hello World'
      click_button 'Create Photo'
      expect(page).to have_content 'Hello World'
      expect(current_path).to eq '/photos'
  end
