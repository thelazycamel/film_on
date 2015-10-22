module FilmOn
  module Services
    module VideoOnDemand

      # VodSearchResult: Struct to handle the response from the search, which includes
      # an array of movies, as well as the actual number returned (total)
      # and the overall total for the seach result (total_found)
      # to get the array of movies we have to do
      # film_on.vod_search.movies
      #
      VodSearchResult = Struct.new(:total, :total_found, :movies)

      # Ref: http://www.filmon.com/page/api-vod

      def genres(opts={})
        return @genres if @genres && !opts[:json]
        json = get_vod("genres")
        if opts[:json]
          return json
        end
        @genres = convert_genres(json)
      end

      # vod_search: calls the vod/search and returns
      # a list of movies filtered by the params and the number returned (total) and the total number for the search (total_found)
      # i.e.
      # film_on.vod_search(genre: "horror").movies => will return all horror movies
      # film_on.vod_search(genre: "horror").total => will return the number of movies return from the feed
      # film_on.vod_search(genre: "horror").total_found => will return the total number of movies available with the given params (useful for pagination)
      #
      ## Params examples:
      #
      # term:
      # Set this to the word or term to search the catalog for. The FilmOn VOD API searches the title and synopses of catalog titles for a match. This parameter is required.
      #
      # start_index:
      # Set this to a zero-based offset into the list that results from the query. By using this with the max_results parameter, you can request successive pages of search results.
      #
      # max_results:
      # Set this to the maximum number of results to return. This number cannot be greater than 100. If you do not specify max_results, the default value is 25.
      #
      # parent_id:
      # search for episodes of specified series.
      #
      # order_by:
      # Order search results by one of following strategies: "relevance" or "date"
      #
      # content_type:
      # Filter and return search results only for specified content_type. Parameter value should be one of : "relevance" or "date"
      #
      # genre:
      # Filter and search for movies only in specified genre. Parameter value should be a slug of corresponding genre, retrieved from /api/vod/genres resource.

      def vod_search(params={}, opts={})
        key = Digest::MD5.hexdigest(params.to_s)
        return @vod_search[key] if @vod_search[key] && !opts[:json]
        json = get_vod("search", params)
        if opts[:json]
          return json
        end
        @vod_search[key] = convert_vod_search(json)
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

      # convert_vod_search: takes the raw JSON
      # and coverts it into an object, which includes
      # the total, total_found and a nice array of movies as ruby objects
      # normally for use after storing the JSON in a caching mechanism
      #
      def convert_vod_search(json)
        hash = JSON.parse(json)
        VodSearchResult.new(
           hash["total"],
           hash["total_found"],
           hash["response"].map{|movie| FilmOn::Movie.new(movie) }
        )
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

      # convert_genres: takes the raw JSON
      # and converts it into a nice ruby array of objects
      #
      def convert_genres(json)
        hash = JSON.parse(json)["response"]
        hash.map{|gen| FilmOn::Genre.new(gen)}
      end

    end
  end
end

