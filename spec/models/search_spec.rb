require 'rails_helper'

RSpec.describe Search, type: :model do
  describe "associations" do
    it "belongs to an article" do
      association = described_class.reflect_on_association(:article)
      expect(association.macro).to eq(:belongs_to)
    end

    it "belongs to a user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end