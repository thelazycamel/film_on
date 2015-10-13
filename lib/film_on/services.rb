module FilmOn

  # Services: calls to the actual services of the API
  # each call is memoized to save calling the API multiple times
  # except when json requested:
  # pass {json: true} to get the raw JSON representation
  # of the channel, normally for self storage in memcache/redis cache
  #
  module Services

    # #channel will get the verbose details for a channel with
    # the given id
    #
    def channel(id, opts={})
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

    # #groups will get the entire current list of groups for
    # FilmOn, each group holds an array of ids of associated channels
    #
    def groups(opts={})
      return @groups if @groups && !opts[:json]
      json = get("groups")
      if opts[:json]
        return json
      end
      @groups = convert_groups(json)
    end

  end

end
