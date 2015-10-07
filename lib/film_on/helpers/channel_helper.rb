module FilmOn

  module ChannelHelper

      def convert_channel(json)
        hash = JSON.parse(json)
        FilmOn::Channel.new(hash)
      end

      def convert_channels(json)
        hash = JSON.parse(json)
        hash.map{|ch| FilmOn::Channel.new(ch)}
      end

  end
end
