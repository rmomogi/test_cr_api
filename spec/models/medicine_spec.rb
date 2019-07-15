require 'rails_helper'

RSpec.describe(Medicine, type: :model) do
  let(:valid_attributes) { { name: 'Aspirina', value: 10.0, quantity: 1, stock: 10 } }
  subject { Medicine.new(valid_attributes) }

  context '#total' do
    it 'multiplies' do
      expect(subject.total).to(eql(10.0))
    end

    describe 'when attributes nil' do
      subject { Medicine.new }

      it 'return total with zero' do
        expect(subject.total).to(be_zero)
      end
    end
  end

  context '#decrement_stock' do
    it 'when has stock' do
      expect(subject.decrement_stock(1)).to be_truthy
    end

    it 'when has not stock' do
      expect { subject.decrement_stock(11) }.to raise_error Exception
    end
  end

  context '#increment_stock' do
    it 'should increment ' do
      subject.increment_stock(1)
      expect(subject.stock).to eq 11
    end
  end
end
