require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders a new page" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when user credentials are valid" do
      it "creates a new user" do
        post :create, params: { user: attributes_for(:user) }

        expect(controller).to redirect_to(root_path)
        expect(flash[:success]).to eq("You have signed up successfully")
        expect(User.first.email).to eq("user@gmail.com")
      end
    end

    context "when user credentials are invalid" do
      it "returns an error message" do
        post :create, params: { user: attributes_for(:user, :invalid) }

        expect(flash[:error]).to include("Email is invalid")
      end
    end
  end
end
