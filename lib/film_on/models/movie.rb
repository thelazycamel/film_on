module FilmOn

  # FilmOn::Movie
  # Movie can have either a basic set of data or a more verbose set
  # depending on whether it is called as part of a vod_search or
  # as in individual call from #movie, takes a raw hash and converts
  # it into a nice ruby object

  class Movie

    Image = Struct.new(:type, :width, :height, :url)

    attr_reader :id, :title, :slug, :description, :type_id, :series_number, :episodes_count, :vendor_id, :vendorka_id
    attr_reader :content_host, :low_quality_file_id, :high_quality_file_id, :parent_id, :exists_on_edgecast
    attr_reader :is_featured, :is_enabled, :deleted_at, :genres, :cast, :crew, :artwork, :poster, :georule, :type
    attr_reader :streams, :content_blocked, :poster_small, :poster_medium, :poster_large

    def initialize(hash)
      @id = hash["id"]
      @title = hash["title"]
      @slug = hash["slug"]
      @description = hash["description"]
      @type_id = hash["type_id"]
      @series_number = hash["series_number"]
      @episodes_count = hash["episodes_count"]
      @vendor_id = hash["vendor_id"]
      @vendorka_id = hash["vendorka_id"]
      @content_host = hash["content_host"]
      @low_quality_file_id = hash["low_quality_file_id"]
      @high_quality_file_id = hash["high_quality_file_id"]
      @parent_id = hash["parent_id"]
      @exists_on_edgecast = hash["exists_on_edgecast"]
      @is_featured = hash["is_featured"]
      @is_enabled = hash["is_enabled"]
      @deleted_at = hash["deleted_at"]
      @genres = hash["genres"]
      @cast = hash["cast"]
      @crew = hash["crew"]
      @artwork = hash["artwork"] #TODO convert to image structs
      @poster = hash["poster"]
      @poster_small = get_image(:small, hash["poster"])
      @poster_medium = get_image(:medium, hash["poster"])
      @poster_large = get_image(:large, hash["poster"])
      @georule = hash["georule"]
      @type = hash["type"]
      @streams = hash["streams"]
      @content_blocked = hash["content_blocked"]
    end

    def get_image(type, image)
      return {} unless image.is_a?(Hash)
      case type
      when :small
        image = (image["thumbs"] && image["thumbs"]["thumb_120p"]) ? image["thumbs"]["thumb_120p"] : image
      when :medium
        image = (image["thumbs"] && image["thumbs"]["thumb_220p"]) ? image["thumbs"]["thumb_220p"] : image
      end
      Image.new(image["type"], image["width"], image["height"], image["url"])
    end

  end

end
