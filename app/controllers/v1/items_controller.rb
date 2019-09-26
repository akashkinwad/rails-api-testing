module V1
  class ItemsController < ApplicationController
    before_action :set_todo
    before_action :check_authorization
    before_action :set_todo_item, only: [:show, :update, :destroy]

    # GET /todos/:todo_id/items
    def index
      @items = @todo.items.paginate(page: params[:page], per_page: 20)
      json_with_pagination_response(@items)
    end

    # GET /todos/:todo_id/items/:id
    def show
      json_response(@item)
    end

    # POST /todos/:todo_id/items
    def create
      @todo.items.create!(item_params)
      json_response(@todo, :created)
    end

    # PUT /todos/:todo_id/items/:id
    def update
      @item.update(item_params)
      head :no_content
    end

    # DELETE /todos/:todo_id/items/:id
    def destroy
      @item.destroy
      head :no_content
    end

    private

    def item_params
      params.permit(:name, :done)
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_todo_item
      @item = @todo.items.find_by!(id: params[:id]) if @todo
    end

    def check_authorization
      unless @todo.user == current_user
        raise(ExceptionHandler::AuthorizationException, Message.authorization_error)
      end
    end
  end
end
