require "httparty"

module FilmOn

  class Base

    include Services::Channels
    include Services::Groups
    include Services::VideoOnDemand

    TV_URI = "www.filmon.com/tv/api/"
    VOD_URI = "www.filmon.com/api/vod/"

    attr_reader :app_key, :app_secret, :session_key

    class ApiError < StandardError; end

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
      @movie = {}
      @vod_search = {}
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
      response = HTTParty.post("#{protocol}#{TV_URI}#{service}", {body: query, headers: {'Content-Type' => 'application/json'}})
      if response && response.code == 200
        return response.body
      else
        raise ApiError
      end
    end

    # Make a GET request to the api with the given service, query and protocol
    #
    def get(service, query={}, protocol="http://")
      query["format"] = "json"
      query["session_key"] = @session_key unless service == "init"
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      response = HTTParty.get("#{protocol}#{TV_URI}#{service}?#{query_string}")
      if response && response.code == 200
        return response.body
      else
        raise ApiError
      end
    end

    def get_vod(service, query={}, protocol="http://")
      query_string = query.map{|k,v| "#{k}=#{v}"}.join("&")
      response = HTTParty.get("#{protocol}#{VOD_URI}#{service}?#{query_string}")
      if response && response.code == 200
        return response.body
      else
        raise ApiError
      end
    end

  end

end
