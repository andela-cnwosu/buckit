require "rails_helper"

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  describe "GET #documentation" do
    it "renders the documentation template" do
      get :documentation

      expect(response).to render_template(:documentation)
    end
  end
end
