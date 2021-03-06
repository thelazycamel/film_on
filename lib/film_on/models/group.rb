module FilmOn

  # Group is a group of channels bundled together
  # such as "Sports" or "UK Live TV"
  # takes a raw hash and converts it into a nice ruby
  # object

  class Group

    attr_reader :group_id, :id, :title, :group, :original_name, :alias, :description
    attr_reader :weight, :logo_uri, :logo_148x148_uri, :logos, :channels, :channels_count

    def initialize(hash)
      @group_id = hash["group_id"]
      @id = hash["id"]
      @title = hash["title"]
      @group = hash["group"]
      @original_name = hash["original_name"]
      @alias = hash["alias"]
      @description = hash["description"]
      @weight = hash["weight"]
      @logo_uri = hash["logo_uri"]
      @logo_148x148_uri = hash["logo_148x148_uri"]
      @logos = hash["logos"]
      @channels = hash["channels"]
      @channels_count = hash["channels_count"]
    end

  end

end
