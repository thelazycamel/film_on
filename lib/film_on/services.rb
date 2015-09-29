module FilmOn

  module Services

    def channel(id)
      return @channel[id] if @channel[id]
      hash = get("channel/#{id}")
      @channel[id] = FilmOn::Channel.new(hash)
    end

    def channels
      return @channels if @channels
      hash = get("channels")
      @channels = hash.map{|ch| FilmOn::Channel.new(ch)}
    end

    def groups
      return @groups if @groups
      hash = get("groups")
      @groups = hash.map{|gr| FilmOn::Group.new(gr)}
    end

  end

end
