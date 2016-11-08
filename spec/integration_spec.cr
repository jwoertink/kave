require "./spec_helper"
require "./sample_app"

# NOTE: These are specs based on the ./sample_app.cr
describe "SampleApp" do

  it "returns This is a public route" do
    get "/users"
    response.body.should eq "This is a public route"
  end

  it "returns for both v1 and v2 routes" do
    get "/v1/users.json"
    response.body.should eq "This is a private route v1"
    get "/v2/users.json"
    response.body.should eq "This is a private route v2"
  end

  it "fails for an invalid version route" do
    get "/v3/users.json"
    response.status_code.should eq 404
  end
end
