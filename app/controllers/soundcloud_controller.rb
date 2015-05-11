class SoundcloudController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  # http_basic_authenticate_with name: 'admin', password: 'secret'
  before_filter :restrict_access, :cors_preflight_check

  def search
    client = SoundCloud.new(:client_id => ENV['SC_CLIENT_ID'])
    @tracks = client.get('/tracks', :q => 'buskers',:track_type => 'original')
    render json: @tracks
  end

  private

  def restrict_access 
    # api_key = ApiKey.find_by_access_token(params[:access_token])
    # head :unauthorized_status unless api_key
    authenticate_or_request_with_http_token do |token,options|
      ApiKey.exists?(access_token: token)
    end
  end

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Origin'] = 'http://localhost:8100'
  end
end