require "./spec_helper"

describe Kave::DSL do
  
  it "takes a version" do
    dsl = Kave::DSL.new("v1")
    dsl.version.should eq "v1"
  end

  it "stores the versioned routes" do
    dsl = Kave::DSL.new("v1")
    dsl.get("/tacos") { |env| "All the tacos" }
    dsl.stored_routes.size.should eq 1
    dsl.stored_routes[0].should eq Tuple.new("/v1/tacos.json", "get")
  end
end
