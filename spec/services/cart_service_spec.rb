require 'rails_helper'

RSpec.describe CartService do
  let(:customer) { Customer.create(name: 'User') }
  let(:medicine) { Medicine.create(name: 'Medicine', quantity: 1, value: 9.99, stock: 10) }
  let(:subject) { described_class.new(customer) }
  let(:cart) { subject.cart }

  describe '#add_item' do
    describe 'should add item on cart' do
      before do
        subject.add_item(medicine)
        @cart_item = cart.cart_items.find_by(medicine_id: medicine.id)
        medicine.reload
      end

      it { expect(@cart_item.quantity).to eq 1 }
      it { expect(medicine.stock).to eq 9 }
    end

    describe 'should raise' do
      it { expect { subject.add_item(medicine, 11) }.to raise_error Exception }
      it { expect(medicine.reload.stock).to eq 10 }
    end
  end

  describe '#remove_item' do
    describe 'should remove item on cart' do
      before do
        subject.add_item(medicine, 5)
        @result = subject.remove_item(medicine, 5)
        @cart_item = cart.cart_items.find_by(medicine_id: medicine.id)
        medicine.reload
      end

      it { expect(@cart_item).to be_nil }
      it { expect(medicine.stock).to eq 10 }
    end

    describe 'should raise' do
      before do
        subject.add_item(medicine, 1)
      end

      it { expect { subject.remove_item(medicine, 11) }.to raise_error Exception }
    end
  end

  describe '#total' do
    it 'should return amount' do
      subject.add_item(medicine, 5)
      expect(subject.total).to eq medicine.value * 5
    end
  end

  describe '#destroy' do
    before { subject.destroy }

    it 'destroy all items' do
      expect(CartItem.where(cart_id: cart.id).size).to be_zero
    end

    it 'destroy cart' do
      expect { cart.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
