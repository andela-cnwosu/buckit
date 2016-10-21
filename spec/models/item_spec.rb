require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:list) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:done) }
  end
end
