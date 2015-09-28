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
      response = call("init")
      @session_key = response["session_key"]
      self
    end

    private

    def call(service, protocol="http://")
      response = HTTParty.get("#{protocol}#{URI}#{service}")
      if response && response.code == 200
        return JSON.parse(response.body)
      else
        #TODO raise error and write to logs
      end
    end

  end

end
