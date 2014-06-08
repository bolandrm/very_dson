require "test_helper"

class RenderDogeTest < ActionDispatch::IntegrationTest
  test "just passes strings through" do
    get root_path
    assert_match "hello doge", response.body
  end
end
