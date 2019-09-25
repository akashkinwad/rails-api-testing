module V1
  class UsersController < ApplicationController
    before_action :check_authorization

    def index
      @users = User.all.paginate(page: params[:page], per_page: 20)
      json_with_pagination_response(@users)
    end

    private

    def check_authorization
      unless current_user.admin?
        raise(ExceptionHandler::AuthorizationException, Message.authorization_error)
      end
    end
  end
end
