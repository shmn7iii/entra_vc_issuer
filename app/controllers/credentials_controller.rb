class CredentialsController < ApplicationController
  def new; end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]

    qr_code_base64 = CreateIssuanceRequestService.call(first_name:, last_name:)

    redirect_to credentials_result_path(qr: qr_code_base64)
  end

  def result
    @qr_code_base64 = params[:qr]
  end
end
