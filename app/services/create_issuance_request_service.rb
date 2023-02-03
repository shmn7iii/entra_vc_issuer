require 'uri'
require 'net/http'

# Create IssuanceAPI Request to Microsoft Entra
# return Base64 of QR code
class CreateIssuanceRequestService < BaseService
  def initialize(first_name:, last_name:, id: nil)
    @access_token = Oauth2Service.call
    @id = id || SecureRandom.uuid
    @first_name = first_name
    @last_name = last_name

    super()
  end

  def call
    uri = URI.parse('https://verifiedid.did.msidentity.com/v1.0/verifiableCredentials/createIssuanceRequest')
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req = Net::HTTP::Post.new(uri.request_uri)
    req['Authorization'] = "bearer #{@access_token}"
    req['Content-Type'] = 'application/json'

    data = {
      "includeQRCode": true,
      "callback": {
        "url": ENV['callback_url'],
        "state": 'Create',
        "headers": {
          "api-key": 'hogehoge'
        }
      },
      "authority": ENV['did'],
      "registration": {
        "clientName": ENV['client_name']
      },
      "type": ENV['credential_type'],
      "manifest": ENV['manifest'],
      "claims": {
        "id": @id,
        "given_name": @first_name,
        "family_name": @last_name
      }
    }.to_json

    req.body = data
    res = http.request(req)

    JSON.parse(res.body)['qrCode']
  end
end
