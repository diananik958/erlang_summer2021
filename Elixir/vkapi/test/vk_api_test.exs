defmodule VkApiTest do
  use ExUnit.Case
  doctest VkApi

  test "greets the world" do
    assert VkApi.hello() == :world
  end
end
