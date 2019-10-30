class ApplicationController < ActionController::API

  def api_success(data = nil, status = 200)
    render json: { success: true, payload: data}, status: status
  end

  def api_fail(error = nil, status = 500)
    render json: { success: false, error: error}, status: status
  end


end
