require "spec_helper"

describe FilmOn::Group do

  let(:session_key) { "d6e651b2e5918b85dc563c1b81981e7b" }
  let(:film_on) { FilmOn::Base.new("foo", "bar") }
  let(:group) { film_on.groups.first }

  before :each do
    stub_request(:get, "http://www.filmon.com/tv/api/init?format=json").with(headers: {'Accept' => '*/*'}).to_return({body: init_response_json})
    stub_request(:get, "http://www.filmon.com/tv/api/groups?format=json&session_key=#{session_key}").with(:headers => {'Accept'=>'*/*'}).
      to_return(:status => 200, :body => groups_response_json, :headers => {})
  end

  it "should be an instance of FilmOn::Group" do
    expect(group).to be_instance_of(FilmOn::Group)
  end

  it "#id" do; expect(group.id).to eq("5"); end
  it "#group_id" do; expect(group.group_id).to eq("5"); end
  it "#title" do; expect(group.title).to eq("UK LIVE TV"); end
  it "#group" do; expect(group.group).to eq("UK LIVE TV"); end
  it "#original_name" do; expect(group.original_name).to eq("UK LIVE TV"); end
  it "#alias" do; expect(group.alias).to eq("uk-live-tv"); end
  it "#description" do; expect(group.description).to eq(""); end
  it "#weight" do; expect(group.weight).to eq("3"); end
  it "#logo_uri" do; expect(group.logo_uri).to eq("http://static.filmon.com/assets/groups/5/logo.png?v2"); end
  it "#logo_148x148_uri" do; expect(group.logo_148x148_uri).to eq("http://static.filmon.com/assets/groups/5/big_logo.png"); end
  it "#logos" do; expect(group.logos).to eq([{"size"=>"56x28", "url"=>"http://static.filmon.com/assets/groups/5/logo.png?v2"}, {"size"=>"148x148", "url"=>"http://static.filmon.com/assets/groups/5/big_logo.png"}]); end
  it "#channels" do; expect(group.channels).to eq(["14", "3698", "1309", "27", "3227", "3166", "361", "25", "1666", "113", "103", "11", "1817", "67", "1820", "26", "1823", "101", "1826", "3211", "2", "65", "97", "22", "851", "845", "370", "2707", "372", "1039", "371", "1808", "1811", "1805", "1952", "3707", "1711", "3383", "2696"]); end
  it "#channels_count" do; expect(group.channels_count).to eq(39); end

end
