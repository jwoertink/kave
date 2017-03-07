require "./spec_helper"

class MyAuthModel < Kave::AuthToken; end

describe Kave::Config do
 
  it "has a default auth_strategy of nil" do
    Kave.configuration.auth_strategy.should eq nil
  end

  it "assigns the auth_strategy to :bearer" do
    Kave.configure { |c| c.auth_strategy = :bearer }
    Kave.configuration.auth_strategy.should eq :bearer
    Kemal::Config::HANDLERS.delete_at(4)
  end

  it "has a default token_model of Kave::AuthToken" do
    Kave.configuration.token_model.should eq Kave::AuthToken
  end

  it "assigns the token_model to MyAuthModel" do
    Kave.configure {|c| c.token_model = MyAuthModel }
    Kave.configuration.token_model.should eq MyAuthModel
  end

  it "has a default format of :json" do
    Kave.configuration.format.should eq :json
  end

  it "adds /check as a public route" do
    Kave.configure {|c| c.public_routes = ["/check"] }
    Kave.configuration.public_routes.should eq ["/check"]
  end
end
