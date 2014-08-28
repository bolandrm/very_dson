require "test_helper"

class RenderDogeTest < ActionDispatch::IntegrationTest
  test "renders dson when requesting dson" do
    get "doge.dson"

    output = response.body

    assert_match /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many(\.|!|,|\?) "doge" is yes wow/,
                 output
  end

  test "renders dson when requesting html if you specifically return DSON" do
    get "doge.html"

    output = response.body

    assert_match /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many(\.|!|,|\?) "doge" is yes wow/,
                 output
  end

  test "renders html if html is requested and handled normally" do
    get "doge/choice.html"

    output = response.body

    assert_match /<html>/, output
  end

  test "renders dson if dson is requested and handled normally" do
    get "doge/choice.dson"

    output = response.body

    assert_match /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many(\.|!|,|\?) "doge" is yes wow/,
                 output
  end
end
