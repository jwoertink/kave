require "./spec_helper"

class MyAuthModel < Kave::AuthToken; end

describe Kave::Config do
 
  it "has a default strategy of :path" do
    Kave.configuration.strategy.should eq :path
  end

  it "assigns the strategy to :header" do
    Kave.configure { |c| c.strategy = :header }
    Kave.configuration.strategy.should eq :header
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
end
