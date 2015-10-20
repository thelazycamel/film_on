module FilmOn
  module Services
    module Groups

      # groups: will get the entire current list of groups for
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

      # convert_groups: takes the raw JSON
      # and converts it into a nice ruby array of objects
      #
      def convert_groups(json)
        hash = JSON.parse(json)
        hash.map{|gr| FilmOn::Group.new(gr)}
      end

      # find_group: a convenience method to
      # find the full detail of any given group
      #
      def find_group(id)
        id = id.to_s
        groups.select{|gr| gr.id == id}.first
      end

    end
  end
end
