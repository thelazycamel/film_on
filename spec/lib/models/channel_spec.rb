require "spec_helper"

describe FilmOn::Channel do

  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }
  let(:film_on) { FilmOn::Base.new("foo", "bar") }


  context "Basic Channel loaded from Channels list" do

    let(:channel) { film_on.channels.first }

    before :each do
      stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
      stub_request(:get, "http://www.filmon.com/tv/api/channels?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
           to_return(:status => 200, :body => channels_response_json, :headers => {})
    end

    it "should return a Channel object" do
      expect(channel).to be_instance_of(FilmOn::Channel)
    end

    it "#id" do; expect(channel.id).to eq("364"); end
    it "#title" do; expect(channel.title).to eq("M6 BOUTIQUE LA CHAINE"); end
    it "#alias" do; expect(channel.alias).to eq("m6-boutique-la-chaine"); end
    it "#logo" do; expect(channel.logo).to eq("http://static.filmon.com/assets/channels/364/logo.png?v2"); end
    it "#big_logo" do; expect(channel.big_logo).to eq("http://static.filmon.com/assets/channels/364/big_logo.png"); end
    it "#content_rating" do; expect(channel.content_rating).to eq("0"); end
    it "#adult_content" do; expect(channel.adult_content).to eq("0"); end
    it "#group" do; expect(channel.group).to eq("FRENCH TV"); end
    it "#group_id" do; expect(channel.group_id).to eq("27"); end
    it "#is_free" do; expect(channel.is_free).to eq("0"); end
    it "#is_free_sd_mode" do; expect(channel.is_free_sd_mode).to eq("1"); end
    it "#type" do; expect(channel.type).to eq("standard"); end
    it "#has_tvguide" do; expect(channel.has_tvguide).to eq(true); end
    it "#seekable" do; expect(channel.seekable).to eq(false); end
    it "#serverside_record" do; expect(channel.serverside_record).to eq(false); end
    it "#extra_big_logo" do; expect(channel.extra_big_logo).to eq("http://static.filmon.com/assets/channels/364/extra_big_logo.png"); end
    it "#upnp_enabled" do; expect(channel.upnp_enabled).to eq(true); end
    it "#is_favorite" do; expect(channel.is_favorite).to eq(false); end

  end

  context "Verbose Channel information from calling channel/#id directly" do

  end

end
