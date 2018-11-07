require 'rails_helper'

describe "user slug" do
  it "when user is logged in we can see user slug" do

    user_1 = create(:user)
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit user_path(user_1)


    expect(current_path).to eq("/users/#{user_1}")

    expect(page).to have_content(user_1.name)
    expect(page).to have_content(user_1.email)
    expect(page).to have_content(user_1.address)

    expect(page).to_not have_content(user_2.name)
    expect(page).to_not have_content(user_2.email)
    expect(page).to_not have_content(user_2.address)
  end
end
