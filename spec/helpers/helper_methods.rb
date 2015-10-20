module HelperMethods

  def init_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/init.json")
  end

  def channels_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/channels.json")
  end

  def channel_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/channel.json")
  end

  def groups_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/groups.json")
  end

  def movie_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/movie.json")
  end

  def movies_response_json
    File.read(File.dirname(__FILE__) + "/../fixtures/movies.json")
  end

end
