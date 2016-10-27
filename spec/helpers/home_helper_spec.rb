require "rails_helper"

RSpec.describe HomeHelper, type: :helper do
  let!(:user) { create :user }

  describe "#link_by_signed_in" do
    context "when a user is signed in" do
      it "returns the documentation path" do
        session[:user_id] = user.id

        expect(helper.link_by_signed_in).to eq("/documentation")
      end
    end

    context "returns the root path" do
      it "returns false" do
        expect(helper.link_by_signed_in).to eq("/")
      end
    end
  end
end
