require "spec_helper"

describe FilmOn::Services::Channels do

  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
  end

  context "#channels" do

    before :each do
      stub_request(:get, "http://www.filmon.com/tv/api/channels?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
         to_return(:status => 200, :body => channels_response_json, :headers => {})
    end

    it "should call the channels list" do
      expect(film_on.channels).to be_instance_of(Array)
    end

    it "should return instances of FilmOn::Channel" do
      expect(film_on.channels.first).to be_instance_of(FilmOn::Channel)
    end

    it "should not call the api on a second request" do
      expect(film_on).to receive(:get).with("channels") {"{}"}
      film_on.channels
      expect(film_on).to_not receive(:get)
      film_on.channels
    end

    it "should return channels list as json when requested" do
      expect(film_on.channels(json: true)).to eq(channels_response_json)
    end


  end

  context "#channel/#id" do

    before :each do
      stub_request(:get, "http://www.filmon.com/tv/api/channel/11?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
         to_return(:status => 200, :body => channel_response_json, :headers => {})
    end

    it "should call a channel given a channel id" do
      expect(film_on.channel(11)).to be_instance_of(FilmOn::Channel)
    end

    it "should not call the api on a second request" do
      expect(film_on).to receive(:get).with("channel/11") {"{}"}
      film_on.channel(11)
      expect(film_on).to_not receive(:get)
      film_on.channel(11)
    end

  end

end
