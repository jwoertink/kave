require "./spec_helper"
require "./sample_app"

class Authorization < Kave::AuthToken
  def self.locate(token : String)
    token == "1e2r3t"
  end
end

# NOTE: These are specs based on the ./sample_app.cr
describe "SampleApp" do
  
  context "when testing route scopes" do
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

  context "when testing bearer handler" do
    Spec.before_each do
      Kave.configure do |c|
        c.auth_strategy = :bearer
        c.token_model = Authorization
      end
    end
    it "fails" do
      get "/v1/users.json"
      response.status_code.should eq 401
    end

    it "succeeds" do
      headers = HTTP::Headers.new
      headers["AUTHORIZATION"] = "Bearer 123"
      get "v1/users.json", headers: headers
    end
  end
end
