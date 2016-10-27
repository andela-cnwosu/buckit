require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "POST #create" do
    context "when user credentials are valid" do
      let!(:create) { post :create, params: { user: attributes_for(:user) } }

      it "creates a new user" do
        expect(User.first.email).to eq("user@gmail.com")
      end

      it "redirects to documentation path with a flash message" do
        expect(controller).to redirect_to(documentation_path)
        expect(flash[:success]).to eq(successful_login_message)
      end
    end

    context "when user credentials are invalid" do
      it "returns an error message" do
        post :create, params: { user: attributes_for(:user, :user_invalid) }

        expect(response.body).to include("Email is invalid")
      end
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
