require "spec_helper"

describe FilmOn::Programme do

  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }
  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:channel) { film_on.channel(11) }
  let(:programme) { channel.programmes.first}

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
    stub_request(:get, "http://www.filmon.com/tv/api/channel/11?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => channel_response_json, :headers => {})
  end

  it "should be an instance of FilmOn::Programme" do
    expect(programme).to be_instance_of(FilmOn::Programme)
  end

  it "#programme" do; expect(programme.programme).to eq("8735"); end
  it "#startdatetime" do; expect(programme.startdatetime).to eq("1443432600"); end
  it "#enddatetime" do; expect(programme.enddatetime).to eq("1443439800"); end
  it "#duration" do; expect(programme.duration).to eq("02:00"); end
  it "#length" do; expect(programme.length).to eq(7200); end
  it "#programme_description" do; expect(programme.programme_description).to eq("Phillip Schofield and Holly Willoughby take a look at the day's news and headlines."); end
  it "#programme_name" do; expect(programme.programme_name).to eq("This Morning"); end
  it "#allow_dvr" do; expect(programme.allow_dvr).to eq(true); end
  it "#allow_reminder" do; expect(programme.allow_reminder).to eq(false); end
  it "#channel_id" do; expect(programme.channel_id).to eq("11"); end
  it "#provider" do; expect(programme.provider).to eq("Digiguide"); end
  it "#vendor_id" do; expect(programme.vendor_id).to eq("123"); end
  it "#series_number" do; expect(programme.series_number).to eq("1"); end
  it "#episode_number" do; expect(programme.episode_number).to eq("2"); end
  it "#series_id" do; expect(programme.series_id).to eq("345"); end
  it "#is_series" do; expect(programme.is_series).to eq("0"); end
  it "#images" do; expect(programme.images.size).to eq(3); end

  context "#images" do

    let(:image) { programme.images.first }
    it "#id" do; expect(image.id).to eq("1604"); end
    it "#type" do; expect(image.type).to eq("2"); end
    it "#size" do; expect(image.size).to eq("350x188"); end
    it "#width" do; expect(image.width).to eq("350"); end
    it "#height" do; expect(image.height).to eq("188"); end
    it "#url" do; expect(image.url).to eq("http://static.filmon.com/assets/tvguide/image%2F8735%2F2%2F8735-ThisMorni-12944216179.71/poster-350x188.jpg"); end
    it "#copyright" do; expect(image.copyright).to eq(""); end

  end

end
