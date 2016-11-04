require "./spec_helper"

describe Kave::Config do
 
  it "has a default strategy of :bearer" do
    Kave.configuration.strategy.should eq :bearer
  end

  it "assigns the strategy of :path" do
    Kave.configure { |c| c.strategy = :path }
    Kave.configuration.strategy.should eq :path
  end
end
