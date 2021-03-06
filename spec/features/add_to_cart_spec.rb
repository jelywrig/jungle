require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

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

  scenario "visitor adds item to cart and cart count increases by 1" do
    

    # ACT
    visit root_path
    #find add buton
    click_on "Add", match: :first

    # DEBUG / VERIFY
    #save_screenshot

    expect(page).to have_text 'My Cart (1)'
    

  end

end