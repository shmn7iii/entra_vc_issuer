class ApplicationController < ActionController::Base
  def callback
    render json: request.body.read
  end
end
