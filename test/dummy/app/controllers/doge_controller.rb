class DogeController < ApplicationController
  def index
    render dson: "hello"
  end
end
