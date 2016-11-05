require "./spec_helper"
require "./sample_app"

describe "SampleApp" do

  it "returns This is a public route" do
    get "/"
    response.body.should eq "This is a public route"
  end

  it "returns for both v1 and v2 routes" do
    Kave.configure {|c| c.strategy = :path }
    get "/v1/"
    response.body.should eq "This is a private route v1"
    get "/v2/"
    response.body.should eq "This is a private route v2"
  end

  it "fails for an invalid version route" do
    Kave.configure {|c| c.strategy = :path}
    get "/v3/"
    response.status_code.should eq 404
  end
end
