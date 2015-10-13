module FilmOn
  module GroupHelper

    # #convert_groups takes the raw JSON
    # and converts it into a nice ruby array of objects
    #
    def convert_groups(json)
      hash = JSON.parse(json)
      hash.map{|gr| FilmOn::Group.new(gr)}
    end

    # #find_group, a convenience method to
    # find the full detail of any given group
    #
    def find_group(id)
      groups.select{|gr| gr.id == id}.first
    end

  end
end
