require 'rails_helper'

RSpec.describe Api::V1::ListsController, type: :controller do
  describe 'PUT #update' do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it "returns an authorization error response" do
        put :update, params: {
          list: attributes_for(:updated_list), id: list.id
        }

        expect(controller).to respond_with(:unauthorized)
      end
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        put :update, params: {
          list: attributes_for(:updated_list), id: list.id
        }

        expect(controller).to respond_with(200)
        expect(List.first.name).to eq("MyBucket")
      end
    end

    context "when user provide invalid parameters" do
      include_context "doorkeeper oauth"

      it "returns a json error" do
        put :update, params: {
          list: attributes_for(:list, :invalid), id: list.id
        }

        expect(response.body).to include("Name can't be blank")
        expect(List.first.name).to be_present
      end
    end
  end
end
