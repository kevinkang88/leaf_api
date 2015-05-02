class LeafApiController < ApplicationController
  def assign_key 
    @key = ApiKey.create!
    render json: @key.access_token
  end
end