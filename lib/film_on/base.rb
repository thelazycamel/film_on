require "HTTParty"

module FilmOn

  class Base

    include Services
    include ChannelHelper
    include GroupHelper

    URI = "www.filmon.com/tv/api/"

    attr_reader :app_key, :app_secret, :session_key

    def initialize(app_key, app_secret)
      @app_key = app_key
      @app_secret = app_secret
      @channel = {}
      init_request
    end

    def init_request
      response = get("init")
      init_hash = JSON.parse(response)
      @session_key = init_hash["session_key"]
      self
    end

    private

    def post(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      full_service_url = "#{protocol}#{URI}#{service}"
      response = HTTParty.post(full_service_url, {body: query, headers: {'Content-Type' => 'application/json'}})
      if response && response.code == 200
        return response.body
      else
        response.response
      end
    end

    def get(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      full_service_url = "#{protocol}#{URI}#{service}?#{query.map{|k,v| "#{k}=#{v}"}.join("&")}"
      response = HTTParty.get(full_service_url)
      if response && response.code == 200
        return response.body
      else
        response.response
      end
    end

  end

end
