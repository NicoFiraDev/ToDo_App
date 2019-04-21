class TasksController < ApplicationController
  before_action :task_id, only: %i[show edit update destroy]
  before_action :list_id, only: %i[new edit create update destroy toggle_status]

  def toggle_status
    @task = Task.find(params[:task_id])
    @task.toggle! :completed
    redirect_to @list
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = 'Task successfully added'
      redirect_to @list
    else
      flash[:error] = @task.errors.full_messages
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      flash[:success] = 'Task updated'
      redirect_to @list
    else
      flash[:error] = @task.errors.full_messages
      render :edit
    end
  end

  def destroy
    flash[:success] = 'Task deleted' if @task.destroy
    redirect_to @list
  end

  private

  def task_params
    params.require(:task).permit(:body, :completed, :urgency, :list_id)
  end

  def task_id
    @task = Task.find(params[:id])
  end

  def list_id
    @list = List.find(params[:list_id])
  end
end
