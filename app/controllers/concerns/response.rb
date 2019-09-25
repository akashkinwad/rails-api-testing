module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def json_with_pagination_response(object, status = :ok)
    render json: object, meta: pagination_attributes(object), status: status
  end

end