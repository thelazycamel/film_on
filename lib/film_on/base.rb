require "httparty"

module FilmOn

  class Base

    include Services
    include ChannelHelper
    include GroupHelper

    URI = "www.filmon.com/tv/api/"

    attr_reader :app_key, :app_secret, :session_key

    # FilmOn Api (http://www.filmon.com/page/api)
    # initialize the wrapper with your app_key and app_secret
    # for development purposes you can use "foo" and "bar"
    # eg.
    # film_on = FilmOn::Base.new("foo", "bar")
    # film_on.channels => returns an array of channels
    # film_on.groups => returns an array of channel groups
    # film_on.channel(14) => returns information for channel with id 14
    #
    def initialize(app_key, app_secret)
      @app_key = app_key
      @app_secret = app_secret
      @channel = {}
      init_request
    end

    private

    # Create the initial handshake to FilmOn
    # and set the @session_key
    #
    def init_request
      response = get("init")
      init_hash = JSON.parse(response)
      @session_key = init_hash["session_key"]
      self
    end

    # Make a POST request to the api with the given service, query and protocol
    #
    def post(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      full_service_url = "#{protocol}#{URI}#{service}"
      response = HTTParty.post(full_service_url, {body: query, headers: {'Content-Type' => 'application/json'}})
      if response && response.code == 200
        return response.body
      else
        #TODO log error
        nil
      end
    end

    # Make a GET request to the api with the given service, query and protocol
    #
    def get(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      full_service_url = "#{protocol}#{URI}#{service}?#{query.map{|k,v| "#{k}=#{v}"}.join("&")}"
      response = HTTParty.get(full_service_url)
      if response && response.code == 200
        return response.body
      else
        #TODO log error
        nil
      end
    end

  end

end
