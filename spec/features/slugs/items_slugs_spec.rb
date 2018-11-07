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
end
