require "spec_helper"

describe FilmOn::Movie do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
    stub_request(:get, "http://www.filmon.com/api/vod/movie?id=5315").with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => movie_response_json, :headers => {})
  end

  it "should be a movie" do
    movie = film_on.movie(5315)
    expect(movie).to be_instance_of(FilmOn::Movie)
  end


end

