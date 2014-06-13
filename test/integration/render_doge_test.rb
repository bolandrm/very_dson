require "test_helper"

class RenderDogeTest < ActionDispatch::IntegrationTest
  test "renders dson" do
    get "doge.dson"

    output = response.body

    assert_match /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many(\.|!|,|\?) "doge" is yes wow/,
                 output
  end
end
