require 'spec_helper'

describe FilmOn do
  it 'has a version number' do
    expect(FilmOn::VERSION).to eq File.read(File.dirname(__FILE__) + "/../VERSION").strip
  end

end
