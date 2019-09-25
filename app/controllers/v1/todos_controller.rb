module V1
  class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    # get current user todos
    @todos = current_user.todos.includes(:items).paginate(page: params[:page], per_page: 20)
    json_with_pagination_response(@todos)
  end

  # GET /todos/:id
  def show
    if @todo.user == current_user
      json_response(@todo)
    else
      raise(ExceptionHandler::AuthorizationException, Message.authorization_error)
    end
  end

  # POST /todos
  def create
    # create todos belonging to current user
    @todo = current_user.todos.create!(todo_params)
    json_response(@todo, :created)
  end

  # PUT /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  # remove `created_by` from list of permitted parameters
  def todo_params
    params.permit(:title)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
  end
end
