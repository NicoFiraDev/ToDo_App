require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  fixtures :users, :lists, :categories

  setup do
    @user = users(:user_one)
    @list = lists(:list_one)
    @category = categories(:category_one)
  end

  before :each do
    sign_in @user
  end

  describe 'Index' do
    setup { get :index }
    it 'Should get index view' do
      should route(:get, lists_path)
        .to(controller: :lists, action: :index)
      should respond_with(200)
      should render_template('index')
    end
  end

  describe 'Show' do
    setup { get :show, params: { id: @list } }
    it 'gets show view' do
      should route(:get, list_path(@list))
        .to(controller: :lists, action: :show, id: @list)
      should respond_with(200)
      should render_template('show')
    end
  end

  describe 'New' do
    render_views
    setup { get :new }
    it 'gets new view' do
      should route(:get, new_list_path)
        .to(controller: :lists, action: :new)
      should respond_with(200)
      should render_template('new')
      should render_template(partial: '_form')
    end
  end

  describe 'Edit' do
    setup { get :edit, params: { id: @list } }
    it 'gets edit view' do
      should route(:get, edit_list_path(@list))
        .to(controller: :lists, action: :edit, id: @list)
      should respond_with(200)
    end
  end

  # describe 'Delete' do
  #   setup { delete :destroy, params: { id: @list } }
  #   it 'show hit delete route' do
  #     should route(:delete, list_path(@list))
  #       .to(controller: :lists, action: :destroy, id: @list)
  #     should respond_with(200)
  #   end
  # end
end

# describe 'Create' do
  #   params = {
  #     list: {
  #       name: @list.name,
  #       user_id: @user.id,
  #       category_id: @category.id
  #     }
  #   }
  #   setup { post :create, params: params }
  #   it 'post to create action' do
  #     should route(:post, lists_path, params = {
  #       list: {
  #         name: @list.name,
  #         user_id: @user.id,
  #         category_id: @category.id
  #       }
  #     })
  #       .to(controller: :lists, actions: :create)
  #     should respond_with(200)
  #   end
    # it 'restrict parameter for list' do
    #   params = {
    #     list: {
    #       name: @list.name,
    #       user_id: @user.id,
    #       category_id: @category.id
    #     }
    #   }
    #   should permit(:name, :user_id, :category_id)
    #     .for(:create, params: params)
    #     .on(:list)
    # end
  # end
    # it 'Should get show view' do
    #   get list_path(@list)
    #   expect(response).to have_http_status(:success)
    #   expect(response).to render_template(:show)
    # end

    # it 'Should get edit view' do
    #   get edit_list_path(@list)
    #   expect(response).to have_http_status(:success)
    #   expect(response).to render_template(:edit)
    # end

    # it 'Should get new view' do
    #   get new_list_path
    #   expect(response).to have_http_status(:success)
    #   expect(response).to render_template(:new)
    # end

    # describe 'Business create and update redirect' do
    #   it 'Creates a business and redirects to the business page' do
    #     get new_business_path
    #     expect(response).to render_template(:new)
    #     post(businesses_path, params: { business:
    #                                 { legal_name: 'Business test' } })
    #     expect(response).to redirect_to(business_path(assigns(:business).id))
    #     follow_redirect!

    #     expect(response).to render_template(:show)
    #     expect(response.body)
    #       .to include("#{assigns(:business).legal_name} was successfully created")
    #   end

    #   it 'Should update a business and redirects to business page' do
    #     get edit_business_path(@business)
    #     expect(response).to render_template(:edit)
    #     patch(business_path, params: { business:
    #                                           { legal_name: 'Business update' } })
    #     expect(response).to redirect_to(business_path(assigns(:business).id))
    #     follow_redirect!

    #     expect(response).to render_template(:show)
    #     expect(response.body)
    #       .to include("#{assigns(:business).legal_name} info updated")
    #   end
    # end

    # describe 'Get profile view' do
    #   it 'returns http success' do
    #     get profile_path(@user)
    #     expect(response).to have_http_status(:success)
    #   end

