require 'rails_helper'

RSpec.describe(Cart, type: :model) do
  let(:customer) { Customer.create(name: 'Customer' ) }
  subject { described_class.create(customer: customer) }

  context 'relationships' do
    it { is_expected.to(belong_to(:customer)) }
  end

  context '#add_cart_item' do
  	let(:medicine) { Medicine.create(name: 'Medicine', stock: 100) }

  	it 'should add item' do
  		subject.add_cart_item(medicine, 1)
  		expect(subject.cart_items.size).to_not be_zero
  	end
  end

  context '#remove_cart_item' do
  	let(:medicine) { Medicine.create(name: 'Medicine', stock: 100) }

  	it 'should remove item' do
  		subject.add_cart_item(medicine, 1)
  		subject.remove_cart_item(medicine, 1)
  		expect(subject.cart_items.size).to be_zero
  	end
  end

  context '#total' do
  	let(:medicine1) { Medicine.create(name: 'Medicine1', stock: 100, value: 1.00) }
  	let(:medicine2) { Medicine.create(name: 'Medicine2', stock: 100, value: 2.00) }

  	it 'should return amount' do
  		subject.add_cart_item(medicine1, 1)
  		subject.add_cart_item(medicine2, 2)

  		total = medicine1.value + (medicine2.value * 2)
  		expect(subject.total).to eq total
  	end
  end

end
