module FilmOn

  module Services

    def channel(id, opts={})
      return @channel[id] if @channel[id]
      json = get("channel/#{id}")
      if opts[:json]
        @channel[id] = json
        return json
      end
      hash = JSON.parse(json)
      @channel[id] = FilmOn::Channel.new(hash)
    end

    def channels(opts={})
      return @channels if @channels
      json = get("channels")
      if opts[:json]
        @channels = json
        return json
      end
      hash = JSON.parse(json)
      @channels = hash.map{|ch| FilmOn::Channel.new(ch)}
    end

    def groups(opts={})
      return @groups if @groups
      json = get("groups")
      if opts[:json]
        @groups = json
        return json
      end
      hash = JSON.parse(json)
      @groups = hash.map{|gr| FilmOn::Group.new(gr)}
    end

  end

end
