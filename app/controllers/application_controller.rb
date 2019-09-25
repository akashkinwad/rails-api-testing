class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include ActionController::MimeResponds

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  def pagination_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      previous_page: collection.previous_page,
      total_pages: collection.total_pages,
      total: collection.total_entries
    }.merge(extra_meta)
  end

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
