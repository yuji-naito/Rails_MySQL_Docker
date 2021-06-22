class V1::Api::SamplesController < ApplicationController
  def index
    render json: { message: 'レスポンスサンプル' }
  end
end
