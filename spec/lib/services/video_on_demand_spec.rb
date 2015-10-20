require "spec_helper"

describe FilmOn::Services::VideoOnDemand do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
  end

  context "#movies" do

    before :each do
      stub_request(:get, "http://www.filmon.com/api/vod/search?genre=horror").with(:headers => {'Accept'=>'*/*'}).
         to_return(:status => 200, :body => movies_response_json, :headers => {})
    end

    it "should call the API Video on Demand search" do
      expect(film_on.movies(genre: "horror")).to be_instance_of(Array)
    end

    it "should return instances of FilmOn::Movie" do
      expect(film_on.movies(genre: "horror").first).to be_instance_of(FilmOn::Movie)
    end

    it "should not call the api on a second request" do
      expect(film_on).to receive(:get_vod).with("search", {genre: "horror"}) { movies_response_json }
      film_on.movies(genre: "horror")
      expect(film_on).to_not receive(:get_vod)
      film_on.movies(genre: "horror")
    end

    it "should return channels list as json when requested" do
      expect(film_on.movies({genre: "horror"},{json: true})).to eq(movies_response_json)
    end

  end

  context "#channel/#id" do

    before :each do
      stub_request(:get, "http://www.filmon.com/api/vod/movie?id=5315").with(:headers => {'Accept'=>'*/*'}).
         to_return(:status => 200, :body => movie_response_json, :headers => {})
    end

    it "should call a channel given a channel id" do
      expect(film_on.movie(5315)).to be_instance_of(FilmOn::Movie)
    end

    it "should not call the api on a second request" do
      expect(film_on).to receive(:get_vod).with("movie", {id: "5315"}) { movie_response_json }
      film_on.movie("5315")
      expect(film_on).to_not receive(:get_vod)
      film_on.movie("5315")
    end

  end

end
