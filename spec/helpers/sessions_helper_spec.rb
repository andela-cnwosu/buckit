require "rails_helper"

RSpec.describe SessionsHelper, type: :helper do
  let!(:user) { create :user }

  describe "#current_user" do
    it "returns a user as saved in the session" do
      session[:user_id] = user.id

      expect(helper.current_user).to eq(user)
    end
  end

  describe "#signed_in?" do
    context "when a user is signed in" do
      it "returns true" do
        session[:user_id] = user.id

        expect(helper.signed_in?).to eq(true)
      end
    end

    context "when a user is not signed in" do
      it "returns false" do
        expect(helper.signed_in?).to eq(false)
      end
    end
  end
end
