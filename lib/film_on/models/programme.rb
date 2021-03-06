module FilmOn

  # Programme holds the detail of a TV programme, it takes a raw hash and
  # converts it into a nice ruby object
  #
  class Programme

    Image = Struct.new(:id, :type, :size, :width, :height, :url, :copyright)

    attr_reader :programme, :startdatetime, :enddatetime, :duration, :length, :programme_description, :programme_name, :allow_dvr
    attr_reader :allow_reminder, :channel_id, :images, :provider, :vendor_id, :series_number, :episode_number, :series_id, :is_series

    def initialize(hash)
      @programme = hash["programme"]
      @startdatetime = hash["startdatetime"]
      @enddatetime = hash["enddatetime"]
      @duration = hash["duration"]
      @length = hash["length"]
      @programme_description = hash["programme_description"]
      @programme_name = hash["programme_name"]
      @allow_dvr = hash["allow_dvr"]
      @allow_reminder = hash["allow_reminder"]
      @channel_id = hash["channel_id"]
      @images = get_images(hash["images"])
      @provider = hash["provider"]
      @vendor_id = hash["vendor_id"]
      @series_number = hash["seriesNumber"]
      @episode_number = hash["episodeNumber"]
      @series_id = hash["seriesId"]
      @is_series = hash["isSeries"]
    end

    def get_images(imgs)
      return [] unless imgs.is_a?(Array)
      imgs.map{|img| Image.new(img["id"], img["type"], img["size"], img["width"], img["height"], img["url"], img["copyright"]) }
    end

  end

end
