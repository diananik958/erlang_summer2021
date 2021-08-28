defmodule SipProjectTest do
  use ExUnit.Case
  doctest SipProject

  test "greets the world" do
    assert SipProject.hello() == :world
  end
end
