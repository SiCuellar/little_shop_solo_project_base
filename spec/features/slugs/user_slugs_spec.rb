require 'rails_helper'

describe "user slug" do
  it "when user is logged in we can see user slug" do

    user_1 = create(:user)
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit user_path(user_1)


    expect(current_path).to eq(user_path(user_1))

    expect(page).to have_content(user_1.name)

    expect(page).to_not have_content(user_2.name)
    expect(page).to_not have_content(user_2.email)
    expect(page).to_not have_content(user_2.address)
  end

  describe 'admin can update user  slugs' do
    it 'lets admin update user slug' do
      @admin = create(:admin)
      @active_merchant = create(:merchant)
      @user = create(:user)
      item_1 = create(:item, user: @active_merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit user_path(@user)

      click_link "Edit User Slug"
      expect(current_path).to eq(edit_admin_user_path(@user))
      fill_in :user_slug, with: "silver"
      click_button 'Update User'

      expect(current_path).to eq('/users/silver')
    end

  end
end
