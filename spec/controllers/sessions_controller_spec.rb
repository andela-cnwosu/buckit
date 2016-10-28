require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create :user }

  describe "POST #create" do
    context "when user is authenticated" do
      it "logs in a user" do
        post :create, params: { session: attributes_for(:user, :login_valid) }

        expect(flash[:success]).to eq(successful_login_message)
        expect(session[:user_id]).to eq(1)
      end

      context "when session return route is set" do
        it "redirects to session return route" do
          session[:return_route] = "http//www.google.com"
          post :create, params: { session: attributes_for(:user, :login_valid) }

          expect(response).to redirect_to("http//www.google.com")
        end
      end

      context "when session return route is not set" do
        it "redirects to the documentation path" do
          post :create, params: { session: attributes_for(:user, :login_valid) }

          expect(response).to redirect_to(documentation_path)
        end
      end
    end

    context "when user is not authenticated" do
      it "returns an error message" do
        post :create, xhr: true, params: {
          session: attributes_for(:user, :user_invalid)
        }

        expect(response.body).to include(invalid_login_message)
        expect(response.content_type).to eq("application/json")
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

    it "sets the session user id to nil" do
      expect(session[:user_id]).to be_nil
    end
  end
end
