require "./spec_helper"

describe Kave do
  describe ".configuration" do
    it "returns an instance of Kave::Config" do
      Kave.configuration.should be_a Kave::Config
    end
  end

  describe ".reset_config!" do
    it "resets the configuration back to default settings" do
      Kave.configure { |c| c.format = :xml }
      Kave.configuration.format.should eq :xml
      Kave.reset_config!
      Kave.configuration.format.should eq :json
    end
  end
end
