module FilmOn
  module GroupHelper

    def convert_groups(json)
      hash = JSON.parse(json)
      hash.map{|gr| FilmOn::Group.new(gr)}
    end

    def find_group(id)
      groups.select{|gr| gr.id == id}.first
    end

  end
end
