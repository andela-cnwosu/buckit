require "rails_helper"

RSpec.describe "All Items", type: :request do
  describe "GET #index" do
    let!(:items) do
      list = create :list
      25.times do |n|
        create(:item, list: list, name: "MyItem#{n}")
      end
    end

    it_behaves_like("unauthorized user", "get", "/api/bucketlists/1/items")
    it_behaves_like("invalid route", "get", "/api/bucketlists/1/item")
    it_behaves_like("serialized resource", "get", "/api/bucketlists/1/items")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"
      let!(:request) { get "/api/bucketlists/1/items" }

      it "retrieves all bucket lists for the user limited by page" do
        expect(response.status).to be(200)
        expect(json.count).to eq(20)
        expect(json[0][:name]).to eq("MyItem0")
      end

      it "returns the item objects by page number and limit" do
        get "/api/bucketlists/1/items?page=9&limit=3"

        expect(json.count).to eq(1)
      end

      it "returns an error message if limit is not in the valid range" do
        get "/api/bucketlists?page=1&limit=101"
        message = paginate_limit_error

        expect(json[:error]).to eq(message)
      end

      it "retrieves a bucket list item if a name is provided" do
        get "/api/bucketlists/1/items?q=MyItem5"

        expect(json.count).to eq(1)
        expect(json[0][:name]).to eq("MyItem5")
      end
    end

    context "when user does not have any bucket list" do
      include_context "doorkeeper oauth"

      it "returns a json error message" do
        Item.destroy_all
        get "/api/bucketlists/1/items"

        expect(response.status).to be(404)
      end
    end
  end
end
