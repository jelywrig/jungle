require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'saves succesfully when all required fields present' do
      category=Category.new(name:"Test")
      category.save
      product=Product.new(name: "Testing",
      description: "Test text blah blah blah",
      category_id: category.id,
      quantity: 5,
      price: 500)
      expect(product).to be_valid

    end
    it 'throws "can\'t be blank" error when name not present' do
      product=Product.new(
      description: "Test text blah blah blah",
      category_id: 1,
      quantity: 5,
      price: 500)

      product.valid?
      expect(product.errors[:name]).to include ("can't be blank")
    end
    it 'throws "can\'t be blank" error when price not present' do
      product=Product.new( name: 'Test',
      description: "Test text blah blah blah",
      category_id: 1,
      quantity: 5)

      product.valid?
      expect(product.errors[:price]).to include ("can't be blank")
    end
    it 'throws "can\'t be blank" error when quantity not present' do
      product=Product.new( name: 'Test',
      description: "Test text blah blah blah",
      category_id: 1,
      price: 500)

      product.valid?
      expect(product.errors[:quantity]).to include ("can't be blank")
    end
    it 'throws "can\'t be blank" error when quantity not present' do
      product=Product.new( name: 'Test',
      description: "Test text blah blah blah",
      quantity: 5,
      price: 500)

      product.valid?
      expect(product.errors[:category]).to include ("can't be blank")
    end

  end
end