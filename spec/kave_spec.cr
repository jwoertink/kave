require "./spec_helper"

describe Kave do
  
  describe ".configuration" do
    it "returns an instance of Kave::Config" do
      Kave.configuration.should be_a Kave::Config
    end
  end

  describe ".reset_config!" do
    it "resets the configuration back to default settings" do
      Kave.configure { |c| c.strategy = :bunk }
      Kave.configuration.strategy.should eq :bunk
      Kave.reset_config!
      Kave.configuration.strategy.should eq :path
    end
  end
end
