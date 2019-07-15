require 'rails_helper'

RSpec.describe(CartItem, type: :model) do
  context 'relationships' do
    it { is_expected.to(belong_to(:cart)) }
    it { is_expected.to(belong_to(:medicine)) }
  end

  context '#total' do
  	let(:medicine) { Medicine.create(name: 'Medicine 1', value: 1.00, stock: 10) }

  	it 'should return amount' do
  		expect(described_class.new(cart: nil, medicine: medicine, quantity: 5).total).to eq (medicine.value * 5)
  	end
  end
end
