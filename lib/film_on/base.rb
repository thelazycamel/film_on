require "JSON"
require "HTTParty"
require_relative "services"

module FilmOn

  class Base

    include Services

    attr_reader :app_key, :app_secret, :session_key
    URI = "www.filmon.com/tv/api/"


    def initialize(app_key, app_secret)
      @app_key = app_key
      @app_secret = app_secret
      init_request
    end

    def init_request
      response = get("init")
      @session_key = response["session_key"]
      self
    end

    private

    def post(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      full_service_url = "#{protocol}#{URI}#{service}"
      response = HTTParty.post(full_service_url, {body: query, headers: {'Content-Type' => 'application/json'}})
      if response && response.code == 200
        return JSON.parse(response.body)
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
        return JSON.parse(response.body)
      else
        response.response
      end
    end

  end

end
