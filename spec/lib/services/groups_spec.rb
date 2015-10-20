require "spec_helper"

describe FilmOn::Services::Groups do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
    stub_request(:get, "http://www.filmon.com/tv/api/groups?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
       to_return(:status => 200, :body => groups_response_json, :headers => {})
  end

  it "should call the groups list" do
    expect(film_on.groups).to be_instance_of(Array)
  end

  it "should return instances of FilmOn::Group" do
    expect(film_on.groups.first).to be_instance_of(FilmOn::Group)
  end

  it "should not call the api on a second request" do
    expect(film_on).to receive(:get).with("groups") {"[]"}
    film_on.groups
    expect(film_on).to_not receive(:get)
    film_on.groups
  end

  it "#find_group should return a group, given an id" do
    group = film_on.find_group("5")
    expect(group.title).to eq("UK LIVE TV")
  end

end
