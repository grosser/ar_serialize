require File.expand_path('spec/spec_helper')

describe ArSerialize do
  it "has a VERSION" do
    ArSerialize::VERSION.should =~ /^\d+\.\d+\.\d+$/
  end
end
