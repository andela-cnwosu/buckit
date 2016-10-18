require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders a new page" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      post :create, params: {
        user: {
          email: "user@gmail.com",
          password: "password",
          password_confirmation: "password"
        }
      }

      expect(controller).to respond_with(302)
      expect(User.first).to be_present
    end
  end
end
