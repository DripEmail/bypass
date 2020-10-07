require "addressable/uri"
require File.dirname(__FILE__) + "/../test_helper.rb"

class Bypass::TextFilterTest < MiniTest::Test
  context "#replace" do
    should "replace URLs" do
      text = "http://yahoo.com"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo", filter.content
    end

    should "not include trailing periods in urls" do
      text = "http://yahoo.com."
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo.", filter.content
    end

    should "not include parenthesis in urls" do
      text = "(http://yahoo.com)"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "(foo)", filter.content
    end

    should "not include trailing commas in urls" do
      text = "http://yahoo.com,"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo,", filter.content
    end

    should "not include trailing exclaims in urls" do
      text = "http://yahoo.com!"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo!", filter.content
    end

    should "not include trailing question marks in urls" do
      text = "http://yahoo.com?"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo?", filter.content
    end

    should "not include trailing semicolons in urls" do
      text = "http://yahoo.com;"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo;", filter.content
    end

    should "not include trailing colons in urls" do
      text = "http://yahoo.com:"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo:", filter.content
    end

    should "skip malformed URLs" do
      text = "http://#"
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal text, filter.content
    end

    should "replace multiple urls" do
      text = "http://yahoo.com http://excite.com, http://pets.com."
      filter = Bypass::TextFilter.new(text)
      filter.replace { "foo" }
      assert_equal "foo foo, foo.", filter.content
    end
  end
end
