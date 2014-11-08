require 'rails_helper'

describe 'commenting' do

  before do
    Photo.create(title:'Hello World Before Edit')
  end

  it 'allows users to leave a comment using a form' do
    visit '/photos'
    click_link 'Comment'
    fill_in "Comments", with: "so so"
    click_button 'Leave comment'

    expect(current_path).to eq '/photos'
    expect(page).to have_content('so so')
  end

end
