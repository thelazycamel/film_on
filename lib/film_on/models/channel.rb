module FilmOn

  # FilmOn::Channel
  # Channel can have either a basic set of data or a more verbose set
  # depending on whether it is called as part of a channels list or
  # as in individual call

  class Channel

    attr_reader :hash, :id, :title, :alias, :logo, :big_logo, :content_rating, :adult_content
    attr_reader :group, :group_id, :is_free, :is_free_sd_mode, :type, :has_tvguide, :seekable
    attr_reader :serverside_record, :extra_big_logo, :upnp_enabled, :is_favorite
    #extended
    attr_reader :is_adult, :is_interactive, :is_vod, :is_vox, :chat_keyword, :recordable, :programmes
    attr_reader :preload_message, :preload_timeout, :is_local, :preload_intro, :images, :schedule, :now_playing, :next_playing, :tvguide

    def initialize(hash)
      @hash = hash
      @id = hash["id"]
      @title = hash["title"]
      @alias = hash["alias"]
      @logo = hash["logo"]
      @big_logo = hash["big_logo"]
      @content_rating = hash["content_rating"]
      @adult_content = hash["adult_content"]
      @group = hash["group"]
      @group_id = hash["group_id"]
      @is_free = hash["is_free"]
      @is_free_sd_mode = hash["is_free_sd_mode"]
      @type = hash["type"]
      @has_tvguide = hash["has_tvguide"]
      @seekable = hash["seekable"]
      @serverside_record = hash["serverside_record"]
      @extra_big_logo = hash["extra_big_logo"]
      @upnp_enabled = hash["upnp_enabled"]
      @is_favorite = hash["is_favorite"]
      #extended
      @is_adult = hash["is_adult"]
      @is_interactive = hash["is_interactive"]
      @is_vod = hash["is_vod"]
      @is_vox = hash["is_vox"]
      @chat_keyword = hash["chat_keyword"]
      @recordable = hash["recordable"]
      @preload_message = hash["preload_message"]
      @preload_timeout = hash["preload_timeout"]
      @is_local = hash["is_local"]
      @preload_intro = hash["preload_intro"]
      @images = hash["images"]
      @schedule = hash["schedule"]
      @now_playing = hash["now_playing"] ? FilmOn::Programme.new(hash["now_playing"]) : nil
      @next_playing = hash["next_playing"] ? FilmOn::Programme.new(hash["next_playing"]) : nil
      @tvguide = get_tvguide(hash["tvguide"])
    end

    def get_tvguide(guide)
      return [] unless guide
      guide.map{|gu| FilmOn::Programme.new(gu) }
    end

    def programmes
      @tvguide
    end

  end

end
