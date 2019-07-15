require 'rails_helper'

RSpec.describe(Customer, type: :model) do
  context 'relationships' do
    it { is_expected.to(have_many(:carts)) }
  end

  context 'name' do
    let(:valid_attributes) { { name: 'orlando oliveira' } }
    subject { Customer.new(valid_attributes) }

    it { expect(subject.name).to eq 'Orlando Oliveira' }
  end
end
