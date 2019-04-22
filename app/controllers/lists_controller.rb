class ListsController < ApplicationController
  before_action :list_id, only: %i[show edit update destroy]
  before_action :categories, only: %i[new create edit]
  before_action :page_current_user

  def index
    @lists = @user.lists
    @page_title = 'Lists'
  end

  def show
    @tasks = @list.tasks
    @page_title = @list.name
  end

  def new
    @list = List.new
  end

  def create
    @page_title = 'Create List'
    @list = List.new(list_params)
    if @list.save
      flash[:success] = "List #{@list.name} successfully created"
      redirect_to @list
    else
      flash[:error] = @list.errors.full_messages
      render :new
    end
  end

  def edit
    @page_title = 'Edit List'
  end

  def update
    if @list.update(list_params)
      flash[:success] = "#{@list.name} updated"
      redirect_to @list
    else
      flash.now[:error] = 'There was a problem updating the list'
      render :edit
    end
  end

  def destroy
    if @list.destroy
      flash[:success] = "#{@list.name} deleted"
    else
      flash[:error] = "There was a problem deleting #{@list.name}"
    end
    redirect_to lists_path
  end

  private

  def page_current_user
    @user = current_user
  end

  def list_id
    @list = List.find(params[:id])
  end

  def categories
    @categories = Category.all
  end

  def list_params
    params.require(:list).permit(:name, :user_id, :category_id)
  end
end
