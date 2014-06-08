class DogeController < ApplicationController
  def index
    render dson: { "foo" => ["bar", "baz", "fizzbuzz"] }
  end
end
