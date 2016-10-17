require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Validations' do

    before(:each) do
      @category = Category.create(name: 'test')

    end

    it "check valid product" do
      @product = Product.create(name: 'test', category: @category, description: 'test', price: 1234, quantity: 12)

      expect(@product.valid?).to eq(true)

      puts @product.errors.size
      puts @product.errors.full_messages
    end

    it "check valid name" do
      @product1 = Product.create(name: nil, category: @category, description: 'test', price: 1234, quantity: 12)

      puts
      puts
      puts @product1.errors.size
      puts @product1.errors.full_messages
    end

    it "check valid price" do
      @product2 = Product.create(name: 'test', category: @category, description: 'test', price: nil, quantity: 12)

      puts
      puts
      puts @product2.errors.size
      puts @product2.errors.full_messages
    end

    it "check valid quantity" do
      @product3 = Product.create(name: 'test', category: @category, description: 'test', price: 123, quantity: nil)

      puts
      puts
      puts @product3.errors.size
      puts @product3.errors.full_messages
    end

    it "check valid category" do

      @product4 = Product.create(name: 'test', category: nil, description: 'test', price: 123, quantity: 12)

      puts
      puts
      puts @product4.errors.size
      puts @product4.errors.full_messages
    end

  end
end
