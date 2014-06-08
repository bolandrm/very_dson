require "test_helper"
module VeryDSON
  class DSONTest < ActiveSupport::TestCase
    test_pairs = [
      {
        input: { "foo" => "bar" },
        output: 'such "foo" is "bar" wow'
      },
      {
        input: { "foo" => ["bar", "baz", "fizzbuzz"] },
        output: /such "foo" is so "bar" (and|also) "baz" (and|also) "fizzbuzz" many wow/
      },
      {
        input: { " \"such " => "bar" },
        output: /such " \"such " is "bar" wow/
      },
      {
        input: {foo: nil},
        output: /such "foo" is empty wow/
      },
      {
        input: {foo:[false,true]},
        output: /such "foo" is so no (and|also) yes many wow/
      },
      {
        input: {"foo"=>"bar","doge"=>"shibe"},
        output: /such "foo" is "bar"(\.|!|,|\?) "doge" is "shibe" wow/
      },
      {
        input: {"foo"=>{"shiba"=>"inu","doge"=>true}},
        output: /such "foo" is such "shiba" is "inu"(\.|!|,|\?) "doge" is yes wow wow/
      },
    ]

    test_pairs.each_with_index do |test_pair, i|
      test "test pair #{i} is resolved correctly" do
        dson = DSON.stringify(test_pair[:input])
        assert_match test_pair[:output], dson
      end
    end
  end
end
