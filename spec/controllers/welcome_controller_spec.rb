require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe "GET #hi" do
    it "returns http success" do
      get :hi
      expect(response).to have_http_status(:success)
    end
  end

end
