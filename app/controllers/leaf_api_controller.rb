class LeafApiController < ApplicationController
  before_filter :cors_preflight_check

  def cors_preflight_check
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Origin'] = 'http://localhost:8100'
  end

  def assign_key 
    @key = ApiKey.create!
    render json: @key.access_token
  end
end