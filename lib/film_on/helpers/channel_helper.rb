module FilmOn

  module ChannelHelper

    # #convert_channel takes the raw JSON
    # and coverts it into a nice ruby object
    # normal for use after storing the JSON in
    # a caching mechanism
    #
    def convert_channel(json)
      hash = JSON.parse(json)
      FilmOn::Channel.new(hash)
    end

    # #convert_channel takes the raw JSON
    # and coverts it into a nice ruby array of
    # objects
    #
    def convert_channels(json)
      hash = JSON.parse(json)
      hash.map{|ch| FilmOn::Channel.new(ch)}
    end

  end
end
