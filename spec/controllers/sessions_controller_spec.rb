require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  before(:all) { create :user }

  describe "POST #create" do
    context "when user is authenticated" do
      it "logs in a user" do
        post :create, params: { session: attributes_for(:user, :login_valid) }

        expect(flash[:success]).to eq(successful_login_message)
      end
    end

    context "when user is not authenticated" do
      it "returns an error message" do
        post :create, xhr: true, params: {
          session: attributes_for(:user, :invalid)
        }

        expect(controller).to respond_with(200)
        expect(response.content_type).to eq("text/javascript")
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
