require "spec_helper"

describe FilmOn::Base do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init").with(headers: {'Accept' => '*/*'}).to_return({body: "{\"session_key\": \"some_random_session_key\"}"})
  end

  it "#initialize should initialize a FilmOn object with an app_key" do
    expect(film_on.app_key).to eq("foo")
  end

  it "#initialize should initialize a FilmOn object with an app_secret" do
    expect(film_on.app_secret).to eq("bar")
  end

  it "#initialize should call the FilmOn init service and return a session_key" do
    expect(film_on.session_key).to eq("some_random_session_key")
  end

end
