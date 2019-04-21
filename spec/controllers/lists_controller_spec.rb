require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  fixtures :users, :lists

  setup do
    @user = users(:user_one)
    @list = lists(:list_one)
  end

  before :each do
    sign_in @user
  end

  describe 'Index' do
    it 'returns http success' do
      get lists_path
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET #show' do
  #   it 'returns http success' do
  #     get :show
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #new' do
  #   it 'returns http success' do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #create' do
  #   it 'returns http success' do
  #     get :create
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #edit' do
  #   it 'returns http success' do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #update' do
  #   it 'returns http success' do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'GET #destroy' do
  #   it 'returns http success' do
  #     get :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
