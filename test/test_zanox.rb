require 'helper'

class TestZanoxConnect < Test::Unit::TestCase
  should "get a new offline session" do
    Zanox::API::Session.offline(TEST_OFFLINE_TOKEN)
    assert_equal(TEST_CONNECT_ID, Zanox::API::Session.connect_id)
  end
end

class TestZanoxProfile < Test::Unit::TestCase
  should "find the users profile" do 
    #$DEBUG = true
    assert_equal(1, Zanox::Profile.find().size)
    assert_equal(TEST_USER_FIRSTNAME, Zanox::Profile.find[0].firstName)
  end
end

class TestZanoxAdspace < Test::Unit::TestCase
  should "find all user's Adspaces" do
    assert(Zanox::Adspace.find(:all).size >= 1)
  end
  should "find the Publisher's Adspace by an id" do
    assert_equal(1, Zanox::Adspace.find(TEST_ADSPACE_ID).size)
  end
end
 
class TestZanoxProduct < Test::Unit::TestCase
  should "find products by a keyword" do
    TEST_PRODUCT_QUERY = "ipod"
    assert(Zanox::Product.find(TEST_PRODUCT_QUERY).size >= 1)
  end
  
  should "find a specific product by its id" do
    TEST_PRODUCT_ID = "710579677e95e3ce2a9ed4f973ec8923"
    assert_equal(1, Zanox::Product.find(TEST_PRODUCT_ID).size)
  end
end

class TestZanoxProgram < Test::Unit::TestCase
  TEST_PROGRAM_QUERY = "Amazon"
  TEST_PROGRAM_ID = "1648"
  
  should "find programs by a keyword" do
    assert(Zanox::Program.find(TEST_PROGRAM_QUERY).size >= 1)
  end
  
  should "find a specific program by its id" do
    assert_equal(1, Zanox::Program.find(TEST_PROGRAM_ID).size)
  end
end

class TestZanoxProgramApplication < Test::Unit::TestCase
  should "find program applications by an adspace" do
    assert(Zanox::ProgramApplication.find(:adspaceId=>TEST_ADSPACE_ID).size >= 1)
  end
end

class TestZanoxSale < Test::Unit::TestCase
  should "find all sales for a given date" do
    assert(Zanox::Sale.find(:date=>TEST_SALE_DATE, :dateType=>'trackingDate').size.should >= 1)
  end
  should "find a sale by its id" do
    assert_equal(1, Zanox::Sale.find(TEST_SALE_ID).size)
  end
end