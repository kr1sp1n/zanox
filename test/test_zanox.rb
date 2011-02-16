require 'helper'

class TestZanoxConnect < Test::Unit::TestCase
  should "get a new offline session" do
    TEST_CONNECT_ID = "668189244D19BABF75AC"
    assert_equal(TEST_CONNECT_ID, Zanox::API::Session.connect_id)
  end
end

class TestZanoxProfile < Test::Unit::TestCase
  should "find the users profile" do
    TEST_FIRSTNAME = "Krispin" 
    assert_equal(1, Zanox::Profile.find.size)
    assert_equal(TEST_FIRSTNAME, Zanox::Profile.find[0].firstName)
  end
end

class TestZanoxAdspace < Test::Unit::TestCase
  TEST_ADSPACE_ID = "99501"
  
  should "find all user's Adspaces" do
    assert(Zanox::Adspace.find(:all).size >= 1)
  end
  should "find the Publisher's Adspace by an id" do
    assert_equal(1, Zanox::Adspace.find(TEST_ADSPACE_ID).size)
  end
end
 
class TestZanoxProduct < Test::Unit::TestCase
  TEST_PRODUCT_QUERY = "ipod"
  TEST_PRODUCT_ID = "afdd090e0ee25e796e5146f6fcd7b15e"
  
  should "find products by a keyword" do
    assert(Zanox::Product.find(TEST_PRODUCT_QUERY).size >= 1)
  end
  
  should "find a specific product by its id" do
    assert_equal(1, Zanox::Product.find(TEST_PRODUCT_ID).size)
  end
end

class TestZanoxProgram < Test::Unit::TestCase
  TEST_PROGRAM_QUERY = "Amazon"
  TEST_PROGRAM_ID = "1648"
  TEST_ADSPACE_ID = "99501"
  
  should "find programs by a keyword" do
    assert(Zanox::Program.find(TEST_PROGRAM_QUERY).size >= 1)
  end
  
  should "find a specific program by its id" do
    assert_equal(1, Zanox::Program.find(TEST_PROGRAM_ID).size)
  end

  should "find programs by an adspace" do
    assert(Zanox::Program.find(:adspaceId=>TEST_ADSPACE_ID).size >= 1)
  end
end

class TestZanoxSale < Test::Unit::TestCase
  TEST_SALE_ID = "92ba89e7-b229-4933-857c-e307c0291856"
  TEST_DATE = "2010-03-02T00:00:00"
  
  should "find all sales for a given date" do
    assert(Zanox::Sale.find(:date=>TEST_DATE, :dateType=>'trackingDate').size.should >= 1)
  end
  should "find a sale by its id" do
    assert_equal(1, Zanox::Sale.find(TEST_SALE_ID).size)
  end
end