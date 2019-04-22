require 'rails_helper'

RSpec.describe ListsController do
  fixtures :users, :lists, :categories

  setup do
    @user = users(:user_one)
    @list = lists(:list_one)
    @category = categories(:category_one)
  end

  before :each do
    sign_in @user
  end

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:list_id) }
  it { should use_before_action(:categories) }

  describe 'Index controller and route' do
    setup { get :index }

    it {
      should route(:get, '/')
        .to(controller: :lists, action: :index)
    }

    it { should respond_with(200) }
    it { should render_template('index') }
  end

  describe 'Show controller and route' do
    setup { get :show, params: { id: @list } }

    it {
      should route(:get, list_path(@list))
        .to(controller: :lists, action: :show, id: @list)
    }

    it { should respond_with(200) }
    it { should render_template('show') }
  end

  describe 'New controller and route' do
    render_views
    setup { get :new }
    it {
      should route(:get, new_list_path)
        .to(controller: :lists, action: :new)
    }

    it { should respond_with(200) }
    it { should render_template('new') }
    it { should render_template(partial: '_form') }
  end

  describe 'Create controller and route with valid params' do
    before do
      @params = {
        list: {
          name: @list.name,
          user_id: @user,
          category_id: @category
        }
      }
    end

    setup { post :create, params: @params }

    it {
      should route(:post, lists_path)
        .to(controller: :lists, action: :create)
    }

    it {
      should set_flash[:success]
        .to("List #{@list.name} successfully created")
    }

    it {
      should permit(:name, :user_id, :category_id)
        .for(:create, params: @params)
        .on(:list)
    }

    it { should redirect_to(list_path(assigns(:list))) }
    it { should_not set_flash[:error] }
  end

  describe 'Create with invalid params no redirect' do
    before do
      @params = {
        list: {
          name: @list.name,
          user_id: nil,
          category_id: @category
        }
      }
    end

    setup { post :create, params: @params }

    it {
      should route(:post, lists_path)
        .to(controller: :lists, action: :create)
    }

    # if valid 'redirect_to' should respond 3xx
    it { should respond_with(200) }
    it { should set_flash[:error] }
    it { should_not set_flash[:success] }
  end

  describe 'Edit controller and route' do
    render_views
    setup { get :edit, params: { id: @list } }

    it {
      should route(:get, edit_list_path(@list))
        .to(controller: :lists, action: :edit, id: @list)
    }

    it { should respond_with(200) }
    it { should render_template('edit') }
    it { should render_template(partial: '_form') }
  end

  describe 'Update controller and route valid params' do
    before do
      @params = {
        id: @list,
        list: {
          name: @list.name,
          user_id: @user,
          category_id: @category
        }
      }
    end

    setup { patch :update, params: @params }

    it {
      should route(:patch, list_path(@list))
        .to(controller: :lists, action: :update, id: @list)
    }

    it {
      should set_flash[:success]
        .to("#{@list.name} updated")
    }

    it { should redirect_to(list_path(@list)) }
    it { should_not set_flash[:error] }

    it {
      should permit(:name, :user_id, :category_id)
        .for(:update, params: @params)
        .on(:list)
    }
  end

  describe 'Update with invalid params no redirect' do
    before do
      @params = {
        id: @list,
        list: {
          name: nil,
          user_id: nil,
          category_id: @category
        }
      }
    end

    setup { patch :update, params: @params }

    # if valid 'redirect_to' should respond 3xx
    it { should respond_with(200) }
    it { should set_flash.now[:error] }
    it { should_not set_flash[:success] }
  end

  describe 'Destroy controller and route' do
    setup { delete :destroy, params: { id: @list } }

    it {
      should route(:delete, list_path(@list))
        .to(controller: :lists, action: :destroy, id: @list)
    }

    it { should set_flash[:success].to("#{@list.name} deleted") }
    it { should redirect_to(lists_path) }
    it { should_not respond_with(200) }
  end
end
