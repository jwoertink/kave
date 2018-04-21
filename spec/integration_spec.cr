require "./spec_helper"
require "./sample_app"

Kave.configure do |c|
  c.auth_strategy = :bearer
  c.token_model = Authorization
  c.version_strategy = :header
end

# Start Kemal before running all the specs
# then stop it when specs are done running.
Kemal.run
at_exit { Kemal.stop }

class Authorization < Kave::AuthToken
  def self.locate(token : String)
    token == "1e2r3t"
  end
end

# NOTE: These are specs based on the ./sample_app.cr
describe "SampleApp" do
  it "returns This is a public route" do
    get "/users"
    response.status_code.should eq 200
    response.body.should eq "This is a public route"
  end

  it "fails to reach the api without proper headers" do
    get "/v1/users"
    response.status_code.should eq 400
    response.body.should eq "Bad Request"
  end
  
  it "fails to reach the api without proper headers authorization" do
    headers = HTTP::Headers.new
    headers["Accept"] = "application/vnd.api.v1+json"
    get "/users", headers: headers
    response.status_code.should eq 401
    response.body.should eq "Unauthorized"
  end

  it "succeeds when given proper headers for v1" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    headers["Accept"] = "application/vnd.api.v1+json"
    get "/users", headers: headers
    response.status_code.should eq 200
    response.body.should eq "This is a private route v1"
  end

  it "doesn't care if you add .json to the end" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    headers["Accept"] = "application/vnd.api.v1+json"
    get "/users.json", headers: headers
    response.status_code.should eq 200
    response.body.should eq "This is a private route v1"
  end

  it "succeeds with proper headers for route ending in param" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    headers["Accept"] = "application/vnd.api.v1+json"
    get "/users/1", headers: headers
    response.status_code.should eq 200
    response.body.should eq "This is users 1"
  end

  it "fails when the version_strategy is :header but you pass the version in the path" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    get "/v1/users/1", headers: headers
    response.status_code.should eq 400
    response.body.should eq "Bad Request"
  end

  it "allows for a post" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    headers["Accept"] = "application/vnd.api.v1+json"
    post "/users/1/articles", headers: headers
    response.status_code.should eq 200
    response.body.should eq %{{"id":"1"}}
  end

  it "fails when given the proper headers, but wrong token for v1" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer badtoken"
    headers["Accept"] = "application/vnd.api.v1+json"
    get "/users", headers: headers
    response.status_code.should eq 401
    response.body.should eq "Unauthorized"
  end

  it "succeeds when given proper headers for v2" do
    headers = HTTP::Headers.new
    headers["AUTHORIZATION"] = "Bearer 1e2r3t"
    headers["Accept"] = "application/vnd.api.v2+json"
    get "/users", headers: headers
    response.status_code.should eq 200
    response.body.should eq "This is a private route v2"
  end

  it "overrides for custom 404 response" do
    get "/not/here"
    response.status_code.should eq 404
    response.body.should eq "This page is missing"
  end
end
