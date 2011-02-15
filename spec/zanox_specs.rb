require File.join(File.dirname(__FILE__),"..","lib","zanox.rb")

describe Zanox::API do
  
  TEST_PUBLIC_KEY = "your public key here"
  TEST_SECRET_KEY = "your secret key here"
  
  before(:all) do
  end
  
  it "should authorize a developer's application" do
    Zanox::API.authorize(TEST_PUBLIC_KEY, TEST_SECRET_KEY).should == true
  end
end

describe Zanox::API::Session do
  it "should get a new session" do
    TEST_AUTH_TOKEN = "your auth token here"
    Zanox::API::Session.new(TEST_AUTH_TOKEN).should == true
  end
  it "should get a new offline session" do
    TEST_OFFLINE_TOKEN = "your offline token here"
    TEST_CONNECT_ID = "publisher connect id here"
    Zanox::API::Session.offline(TEST_OFFLINE_TOKEN)
    Zanox::API::Session.connect_id.should == TEST_CONNECT_ID
  end
end

describe Zanox::Profile do
  it "should find the users profile" do
    Zanox::Profile.find.size.should == 1
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
  TEST_ADSPACE_ID = "1289612"
  
  it "should find programs by a keyword" do
    Zanox::Program.find(TEST_PROGRAM_QUERY).size.should >= 1
  end
  
  it "should find a specific program by its id" do
    Zanox::Program.find(TEST_PROGRAM_ID).size.should == 1
  end

  it "should find programs by an adspace" do
    Zanox::Program.find(:adspaceId=>TEST_ADSPACE_ID).size.should >= 1
  end
end

describe Zanox::Adspace do
  # Adspace.find
  TEST_ADSPACE_ID = "99501"
  
  it "should find all user's Adspaces" do
    Zanox::Adspace.find(:all).size.should >=1
  end
  it "should find the users Adspace by an id" do
    Zanox::Adspace.find(TEST_ADSPACE_ID).size.should == 1
  end
end

describe Zanox::Sale do
  # Sale.find
  TEST_SALE_ID = "92ba89e7-b229-4933-857c-e307c0291856"
  TEST_DATE = "2010-03-02T00:00:00"
  it "should find all sales for a given date" do
    Zanox::Sale.find(:date=>TEST_DATE, :dateType=>'trackingDate').size.should >=1
  end
  it "should find a sale by its id" do
    Zanox::Sale.find(TEST_SALE_ID).size.should == 1
  end
end