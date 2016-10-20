require 'rails_helper'

RSpec.describe Api::V1::ListsController, type: :controller do
  describe 'POST #create' do
    context "when user has not provided the authorization code" do
      it "returns an authorization error response" do
        post :create, params: { name: "mybucket" }

        expect(controller).to respond_with(:unauthorized)
      end
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        post :create, params: { name: "mybucket" }

        expect(controller).to respond_with(201)
        expect(List.first.name).to eq("mybucket")
      end
    end

    context "when user provide invalid parameters" do
      include_context "doorkeeper oauth"

      it "returns a json error" do
        post :create, params: { name: nil }

        expect(response.body).to include("Name can't be blank")
        expect(List.first).to be_nil
      end
    end
  end
end
