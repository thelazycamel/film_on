module FilmOn

  # Genre is a group of movies bundled together
  # such as "Sports" or "Horror"
  # takes a raw hash and converts it into a nice ruby
  # object

  class Genre

    Image = Struct.new(:type, :width, :height, :url)

    attr_reader :id, :vendorka_id, :name, :slug, :position
    attr_reader :content_count, :updated_at, :description, :images
    attr_reader :standard_image, :retina_image

    def initialize(hash)
      @id = hash["id"]
      @vendorka_id = hash["vendorka_id"]
      @name = hash["name"]
      @slug = hash["slug"]
      @position = hash["position"]
      @content_count = hash["content_count"]
      @updated_at = hash["updated_at"]
      @description = hash["description"]
      @images = get_images(hash["images"])
    end

    def standard_image
      images.select{|i| i.type == "logo"}.first
    end

    def retina_image
      images.select{|i| i.type == "logo-retina"}.first
    end

    def get_images(imgs)
      return [] unless imgs.is_a?(Array)
      imgs.map{|img| Image.new(img["type"], img["width"], img["height"], img["url"]) }
    end

  end

end
