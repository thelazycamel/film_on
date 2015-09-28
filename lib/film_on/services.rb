module FilmOn

  module Services

    def channel(id)
      get("channel/#{id}")
    end

    def channels
      get("channels")
    end

    def groups
      get("groups")
    end

  end

end
