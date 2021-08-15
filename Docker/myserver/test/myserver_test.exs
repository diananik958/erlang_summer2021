defmodule MYSERVERTest do
  use ExUnit.Case
  doctest MYSERVER

  test "greets the world" do
    assert MYSERVER.hello() == :world
  end
end
