require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "visit product details page from homepage" do
    

    # ACT
    visit root_path
    #click on the first product link
    first('a > h4').click

    # DEBUG / VERIFY
    #save_screenshot

    #check for css class specific to details page
    expect(page).to have_css ".product-detail"

    #save_screenshot
   

  end

end