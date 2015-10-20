module FilmOn
  module Services
    module Channels

      # #channel will get the verbose details for a channel with
      # the given id
      #
      def channel(id, opts={})
        id = id.to_s
        return @channel[id] if @channel[id] && !opts[:json]
        json = get("channel/#{id}")
        if opts[:json]
          return json
        end
        @channel[id] = convert_channel(json)
      end

      # #channels will get the entire current list of channels for
      # FilmOn, each channels has a small amount of useful data,
      # refer to #channel for additional channel information.
      #
      def channels(opts={})
        return @channels if @channels && !opts[:json]
        json = get("channels")
        if opts[:json]
          return json
        end
        @channels = convert_channels(json)
      end

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
end
