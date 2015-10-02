module FilmOn

  module Services

    def channel(id, opts={})
      return @channel[id] if @channel[id]
      json = get("channel/#{id}")
      if opts[:json]
        @channel[id] = json
        return json
      end
      @channel[id] = convert_channel(id, json)
    end

    def channels(opts={})
      return @channels if @channels
      json = get("channels")
      if opts[:json]
        @channels = json
        return json
      end
      @channels = convert_channels(json)
    end

    def groups(opts={})
      return @groups if @groups
      json = get("groups")
      if opts[:json]
        @groups = json
        return json
      end
      @groups = convert_groups(json)
    end

  end

end
