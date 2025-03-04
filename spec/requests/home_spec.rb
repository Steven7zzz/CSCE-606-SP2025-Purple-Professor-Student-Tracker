require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /" do
    context "when not signed in" do
      it "redirects to the sign-in page" do
        get root_path
        expect(response).to have_http_status(:found) # 302 Redirect
        expect(response).to redirect_to(new_user_session_path) 
      end
    end
  end
end
