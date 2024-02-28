defmodule FeatherbookWeb.ErrorJSONTest do
  use FeatherbookWeb.ConnCase, async: true

  test "renders 404" do
    assert FeatherbookWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert FeatherbookWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
