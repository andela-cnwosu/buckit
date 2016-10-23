require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user, email: 'new_user@gmail.com') }

  describe "associations" do
    it { is_expected.to have_secure_password }
    it { is_expected.to have_many(:lists) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value("joe@gmail.com").for :email }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_confirmation_of(:password) }
    it { is_expected.to validate_length_of(:password) }
  end
end
