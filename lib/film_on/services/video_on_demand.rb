module FilmOn
  module Services
    module VideoOnDemand

      # movies: calls the vod/search and returns
      # a list of movies filtered by the params
      # i.e. film_on.movies(genre: "horror") will
      # return all horror movies
      #
      def movies(params={}, opts={})
        key = Digest::MD5.hexdigest(params.to_s)
        return @vod_search[key] if @vod_search[key] && !opts[:json]
        json = get_vod("search", params)
        if opts[:json]
          return json
        end
        @vod_search[key] = convert_movies(json)
      end

      # movie: retrieve a specific movie with a given id
      #
      def movie(id, opts={})
        id = id.to_s
        return @movie[id] if @movie[id] && !opts[:json]
        json = get_vod("movie", {id: id})
        if opts[:json]
          return json
        end
        @movie[id] = convert_movie(json)
      end

      # convert_movies: takes the raw JSON
      # and coverts it into a nice array of ruby objects
      # normal for use after storing the JSON in
      # a caching mechanism
      #
      def convert_movies(json)
        hash = JSON.parse(json)["response"]
        hash.map{|movie| FilmOn::Movie.new(movie) }
      end

      # convert_movie: takes the raw JSON
      # and coverts it into a nice ruby object
      # normal for use after storing the JSON in
      # a caching mechanism
      #
      def convert_movie(json)
        hash = JSON.parse(json)["response"]
        FilmOn::Movie.new(hash)
      end

    end
  end
end

