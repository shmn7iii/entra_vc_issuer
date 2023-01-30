require 'uri'
require 'net/http'

# OAuth2.0
# return ACCESS TOKEN
class Oauth2Service < BaseService
  def call
    tenant_id = ENV['tenant_id']
    client_id = ENV['client_id']
    client_secret = ENV['client_secret']

    res = Net::HTTP.post_form(URI("https://login.microsoftonline.com/#{tenant_id}/oauth2/v2.0/token"),
                              grant_type: 'client_credentials',
                              scope: '3db474b9-6a0c-4840-96ac-1fceb342124f/.default',
                              client_id:,
                              client_secret:)

    JSON.parse(res.body)['access_token']
  end
end
