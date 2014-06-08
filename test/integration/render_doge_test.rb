require "test_helper"

class RenderDogeTest < ActionDispatch::IntegrationTest
  test "renders dson" do
    get root_path

    output = response.body.gsub("also", "and")

    assert_match /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many wow/,
                 output
  end
end
