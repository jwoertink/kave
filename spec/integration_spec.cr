require "./spec_helper"
require "./sample_app"

describe "SampleApp" do

  it "returns This is a public route" do
    get "/"
    response.body.should eq "This is a public route"
  end

  it "returns This is a private route" do
    Kave.configure {|c| c.strategy = :path }
    get "/v1/"
    response.body.should eq "This is a private route"
  end

end
