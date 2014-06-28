class DogeController < ApplicationController
  def index
    respond_to do |f|
      f.html { render_it }
      f.dson { render_it }
    end
  end

  def choice
    respond_to do |f|
      f.html
      f.dson { render_it }
    end
  end

  def render_it
    render dson: { "foo" => ["bar", "baz", "fizzbuzz"], doge: true }
  end
end
