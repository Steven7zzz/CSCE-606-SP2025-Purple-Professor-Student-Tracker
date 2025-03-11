require 'rails_helper'

RSpec.describe PeerTeachersController, type: :controller do
    let(:user) { create(:user) }
    let(:valid_attributes) { attributes_for(:peer_teacher) }
    let(:invalid_attributes) { attributes_for(:peer_teacher, email: nil) }
  
    it "creates a valid PeerTeacher" do
        peer_teacher = FactoryBot.build(:peer_teacher)
        expect(peer_teacher).to be_valid
    end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new PeerTeacher" do
        expect {
          post :create, params: { peer_teacher: attributes_for(:peer_teacher) }
        }.to change(PeerTeacher, :count).by(1)
      end

      it "redirects to the created peer_teacher" do
        post :create, params: { peer_teacher: attributes_for(:peer_teacher) }
        expect(response).to redirect_to(PeerTeacher.last)
      end
    end

    context "with invalid parameters" do
        it "does not create a new PeerTeacher" do
          expect {
            post :create, params: { peer_teacher: invalid_attributes }
          }.not_to change(PeerTeacher, :count)
  
          expect(response).to render_template(:new)
        end
    end

      it "renders the 'new' template" do
        post :create, params: { peer_teacher: attributes_for(:peer_teacher, email: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  it "assigns @peer_teachers" do
    create(:peer_teacher)

    get :index
    expect(assigns(:peer_teachers)).to eq(PeerTeacher.all)
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: peer_teacher.id }
      expect(response).to have_http_status(:success)
    end

    it "assigns @peer_teacher" do
      get :show, params: { id: peer_teacher.id }
      expect(assigns(:peer_teacher)).to eq(peer_teacher)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "assigns a new PeerTeacher" do
      get :new
      expect(assigns(:peer_teacher)).to be_a_new(PeerTeacher)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new PeerTeacher" do
        expect {
          post :create, params: { peer_teacher: attributes_for(:peer_teacher) }
        }.to change(PeerTeacher, :count).by(1)
      end

      it "redirects to the created peer_teacher" do
        post :create, params: { peer_teacher: attributes_for(:peer_teacher) }
        expect(response).to redirect_to(PeerTeacher.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new PeerTeacher" do
        expect {
          post :create, params: { peer_teacher: attributes_for(:peer_teacher, email: nil) }
        }.not_to change(PeerTeacher, :count)
      end

      it "renders the 'new' template" do
        post :create, params: { peer_teacher: attributes_for(:peer_teacher, email: nil) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: peer_teacher.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested peer_teacher" do
        patch :update, params: { id: peer_teacher.id, peer_teacher: { first_name: "Updated Name" } }
        peer_teacher.reload
        expect(peer_teacher.first_name).to eq("Updated Name")
      end

      it "redirects to the peer_teacher" do
        patch :update, params: { id: peer_teacher.id, peer_teacher: { first_name: "Updated Name" } }
        expect(response).to redirect_to(peer_teacher)
      end
    end

    context "with invalid parameters" do
      it "does not update the peer_teacher" do
        patch :update, params: { id: peer_teacher.id, peer_teacher: { email: nil } }
        peer_teacher.reload
        expect(peer_teacher.email).to eq("john.doe@example.com")
      end

      it "renders the 'edit' template" do
        patch :update, params: { id: peer_teacher.id, peer_teacher: { email: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested peer_teacher" do
      peer_teacher = create(:peer_teacher)
      expect {
        delete :destroy, params: { id: peer_teacher.id }
      }.to change(PeerTeacher, :count).by(-1)
    end

    it "redirects to the peer_teachers list" do
      peer_teacher = create(:peer_teacher)
      delete :destroy, params: { id: peer_teacher.id }
      expect(response).to redirect_to(peer_teachers_path)
    end
  end
end