require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

describe Zanox::API do
  
  # authenticate
  TEST_CONNECT_ID = "your connect id here"
  TEST_SECRET_KEY = "your secret key here"
  
  before(:all) do
  end
  
  it "should authenticate a developer" do
    Zanox::API.authenticate(TEST_CONNECT_ID, TEST_SECRET_KEY).should == true
  end
end

describe Zanox::Product do
  # Product.find
  TEST_PRODUCT_QUERY = "ipod"
  TEST_PRODUCT_ID = "afdd090e0ee25e796e5146f6fcd7b15e"
  
  it "should find products by a keyword" do
    Zanox::Product.find(TEST_PRODUCT_QUERY).size.should >= 1
  end
  
  it "should find a specific product by its id" do
    Zanox::Product.find(TEST_PRODUCT_ID).size.should == 1
  end
end

describe Zanox::Program do
  # Program.find
  TEST_PROGRAM_QUERY = "Amazon"
  TEST_PROGRAM_ID = "1648"
  
  it "should find programs by a keyword" do
    Zanox::Program.find(TEST_PROGRAM_QUERY).size.should >= 1
  end
  
  it "should find a specific program by its id" do
    Zanox::Program.find(TEST_PROGRAM_ID).size.should == 1
  end
end

describe Zanox::Adspace do
  # Adspace.find
  TEST_ADSPACE_ID = "1289612"
  
  it "should find all user's Adspaces" do
    Zanox::Adspace.find(:all).size.should >=1
  end
  it "should find the users Adspace by an id" do
    Zanox::Adspace.find(TEST_ADSPACE_ID).size.should == 1
  end
end