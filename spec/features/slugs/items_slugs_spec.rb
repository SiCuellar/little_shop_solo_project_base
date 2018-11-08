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
      @user = create(:user)
      item_1 = create(:item, user: @active_merchant)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)


      visit item_path(item_1)
      click_link "Edit Item Slug"
      expect(current_path).to eq(edit_admin_item_path(item_1))
      fill_in :item_slug, with: "existenceispain"
      click_button 'Update Item'

      expect(current_path).to eq('/items/existenceispain')
    end

  end
end
