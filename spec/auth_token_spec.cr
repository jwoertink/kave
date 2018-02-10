require "./spec_helper"

describe Kave::AuthToken do
  
  it "returns true for the locate method" do
    Kave::AuthToken.locate("anything").should eq true
  end
end
