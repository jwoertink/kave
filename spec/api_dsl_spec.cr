require "./spec_helper"

describe Kave::ApiDSL do
  it "takes a version" do
    dsl = Kave::ApiDSL.new("v1")
    dsl.version.should eq "v1"
  end

  # Pulls in all the same methods Kemal has
  {% for method in HTTP_METHODS %}
  it "has a {{method.id}} method" do
    dsl = Kave::ApiDSL.new("v1")
    dsl.{{method.id}}("/posts") { |env| "posts" }.should eq nil
  end
  {% end %}

end
