require 'rails_helper'

RSpec.describe TasksController do
  fixtures :users, :lists, :tasks

  setup do
    @user = users(:user_one)
    @list = lists(:list_one)
    @task = tasks(:task_one)
  end

  before :each do
    sign_in @user
  end

  it { should use_before_action(:authenticate_user!) }
  it { should use_before_action(:list_id) }
  it { should use_before_action(:task_id) }

  describe 'Toggle Status controller and route' do
    setup {
      get :toggle_status,
          params: { list_id: @list,
                    task_id: @task }
    }

    it {
      should route(:get, list_task_toggle_status_path(@list, @task))
        .to(controller: :tasks,
            action: :toggle_status,
            list_id: @list, task_id: @task)
    }

    it { should redirect_to(list_path(@list)) }
  end

  describe 'New controller and route' do
    setup { get :new, params: { list_id: @list } }

    it {
      should route(:get, new_list_task_path(@list))
        .to(controller: :tasks, action: :new, list_id: @list)
    }

    it { should respond_with(200) }
    it { should render_template('new') }
  end

  describe 'Create controller and route with valid params' do
    before do
      @params = {
        list_id: @list,
        task: {
          body: @task.body,
          completed: @task.completed,
          urgency: @task.urgency,
          list_id: @list
        }
      }
    end

    setup { post :create, params: @params }

    it {
      should route(:post, list_tasks_path(@list))
        .to(controller: :tasks, action: :create, list_id: @list)
    }

    it {
      should permit(:body, :completed, :urgency, :list_id)
        .for(:create, params: @params)
        .on(:task)
    }

    it { should set_flash[:success].to('Task successfully added') }
    it { should_not set_flash[:error] }
    it { should redirect_to(@list) }
  end
   
  describe 'Create controller and route with invalid params' do
    before do
      @params = {
        list_id: @list,
        task: {
          body: nil,
          completed: nil,
          urgency: nil,
          list_id: nil
        }
      }
    end

    setup { post :create, params: @params }

    it {
      should route(:post, list_tasks_path(@list))
        .to(controller: :tasks, action: :create, list_id: @list)
    }
    
    # if valid 'redirect_to' should respond 3xx
    it { should respond_with(200) }
    it { should set_flash[:error] }
    it { should_not set_flash[:success] }
  end

  describe 'Edit controller and route' do
    setup { get :edit, params: { list_id: @list, id: @task} }

    it {
      should route(:get, edit_list_task_path(@list, @task))
        .to(controller: :tasks,
            action: :edit, list_id: @list, id: @task)
    }

    it { should respond_with(200) }
    it { should render_template('edit') }
  end

  describe 'Update controller and route valid params' do
    before do
      @params = {
        list_id: @list,
        id: @task,
        task: {
          body: @task.body,
          completed: @task.completed,
          urgency: @task.urgency,
          list_id: @list
        }
      }
    end

    setup { patch :update, params: @params }

    it {
      should route(:patch, list_task_path(@list, @task))
        .to(controller: :tasks,
            action: :update, list_id: @list, id: @task)
    }

    it {
      should set_flash[:success]
        .to('Task updated')
    }

    it { should redirect_to(list_path(@list)) }
    it { should_not set_flash[:error] }

    it {
      should permit(:body, :completed, :urgency, :list_id)
        .for(:update, params: @params)
        .on(:task)
    }
  end

  describe 'Update with invalid params no redirect' do
    before do
      @params = {
        list_id: @list,
        id: @task,
        task: {
          body: nil,
          completed: nil,
          urgency: nil,
          list_id: nil
        }
      }
    end

    setup { patch :update, params: @params }

    # if valid 'redirect_to' should respond 3xx
    it { should respond_with(200) }
    it { should set_flash[:error] }
    it { should_not set_flash[:success] }
  end

  describe 'Destroy controller and route' do
    setup { delete :destroy, params: { list_id: @list, id: @task } }

    it {
      should route(:delete, list_task_path(@list, @task))
        .to(controller: :tasks,
            action: :destroy, list_id:@list, id: @task)
    }

    it { should set_flash[:success].to('Task deleted') }
    it { should redirect_to(@list) }
    it { should_not respond_with(200) }
  end
end
