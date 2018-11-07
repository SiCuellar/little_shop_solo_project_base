require 'rails_helper'

describe "user sees one item(slug)" do
  it "on item show page with item attributes" do
    @merchant = create(:merchant)

    item_1 = create(:item, user: @merchant)
    item_2 = create(:item, user: @merchant)

    visit item_path(item_1)

    expect(current_path).to eq(item_path(item_1))

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.price)
    expect(page).to have_content(item_1.description)

    expect(page).to_not have_content(item_2.name)
    expect(page).to_not have_content(item_2.price)
    expect(page).to_not have_content(item_2.description)
  end

  describe 'admin can update item slugs' do
    it 'lets admin update item slug' do
      @admin = create(:admin)
      @active_merchant = create(:merchant)
      @inactive_merchant = create(:inactive_merchant)
      @user = create(:user)
      item_1 = create(:item, user: @active_merchant)

      visit login_path

      fill_in :email, with: @admin.email
      fill_in :password, with: @admin.password

      click_button 'Log in'

      visit item_path(item_1)
      save_and_open_page
      click_link "Edit Item Slug"

      expect(current_path).to eq(edit_admin_item_path(item_1))

      fill_in :item_slug, with: "existenceispain"

      click_button 'Update Item'

      expect(current_path).to eq('/items/existenceispain')
    end

  end
end
