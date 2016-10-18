require 'rails_helper'

RSpec.feature "Vistor clicks on product to see product details", type: :feature, js: true do
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

  scenario "Visit product details" do
    visit '/products/1'

    expect(page).to have_text("Apparel")
  end

end
