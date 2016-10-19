require 'rails_helper'

RSpec.describe Api::V1::ListsController, type: :controller do
  describe 'POST #create' do
    let!(:user) do
      user = create :user
      session[:user_id] =  user.id
    end

    context "when user has not provided the authorization code" do
      it "returns an authorization error response" do
        post :create, params: { name: "mybucket" }

        expect(controller).to respond_with(:unauthorized)
      end
    end
  end
end
