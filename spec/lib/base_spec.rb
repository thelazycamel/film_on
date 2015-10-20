require "spec_helper"

describe FilmOn::Base do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
  end

  it "#initialize should initialize a FilmOn object with an app_key" do
    expect(film_on.app_key).to eq("foo")
  end

  it "#initialize should initialize a FilmOn object with an app_secret" do
    expect(film_on.app_secret).to eq("bar")
  end

  it "#initialize should call the FilmOn init service and return a session_key" do
    expect(film_on.session_key).to eq(session_key)
  end

end
