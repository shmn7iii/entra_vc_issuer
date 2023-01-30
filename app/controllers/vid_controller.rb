class VidController < ApplicationController
  def new; end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]

    qr_code_base64 = CreateIssuanceRequestService.call(first_name:, last_name:)

    redirect_to vid_path(qr_code_base64)
  end

  def show
    @qr_code_base64 = params[:id]
  end
end
