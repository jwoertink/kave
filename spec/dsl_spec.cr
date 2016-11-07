require "./spec_helper"

describe Kave::DSL do
  Spec.before_each do
    Kave.reset_config!
  end
  
  it "takes a version" do
    dsl = Kave::DSL.new("v1")
    dsl.version.should eq "v1"
  end

  it "stores the versioned routes" do
    dsl = Kave::DSL.new("v1")
    dsl.get("/users") { |env| "All the users" }
    dsl.stored_routes.size.should eq 1
    dsl.stored_routes[0].should eq Tuple.new("/v1/users", "get")
  end
end
