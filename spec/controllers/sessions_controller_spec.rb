require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before(:all) { create :user }

  describe "POST #create" do
    context "when user is authenticated" do
      it "logs in a user" do
        post :create, params: { session: attributes_for(:user, :login_valid) }

        expect(controller).to respond_with(302)
        expect(User.first).to be_present
      end
    end

    context "when user is not authenticated" do
      it "returns an error message" do
        post :create, params: { session: attributes_for(:user, :invalid) }

        expect(flash[:error]).to include(invalid_login_message)
      end
    end
  end

  describe "POST #destroy" do
    let!(:destroy) { post :destroy }

    it "redirects to the root path" do
      expect(response).to redirect_to(root_path)
    end

    it "shows successful message to the user" do
      expect(flash[:success]).to eq(successful_logout_message)
    end
  end
end
