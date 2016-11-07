require "./spec_helper"

describe Kave do
  
  describe ".configuration" do
    it "returns an instance of Kave::Config" do
      Kave.configuration.should be_a Kave::Config
    end
  end
end
