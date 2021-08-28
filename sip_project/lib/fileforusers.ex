defmodule FileForUsers do
  @moduledoc """
  File agent for reading users names and secrets from file
  """
  require Logger

  use Agent

  @name {:global, __MODULE__}

  def start_link do
    Agent.start_link(fn -> read_file() end, name: @name)
  end

  def start_link([]) do
    Agent.start_link(fn -> read_file() end, name: @name)
  end

  def read_file do
    {:ok, file} = File.read("users.txt")
    splited = file |> String.split("\n")
    users = Map.new()
    users = loop(0, List.delete(splited, ""), users)
    users
  end

  def loop(i, list, map) do
    if i < length(list) do
      #Logger.info(Enum.at(list, i))
      #Logger.info(Enum.at(list, i+1))
      map = Map.put_new(map, String.to_integer(Enum.at(list, i)), String.to_integer(Enum.at(list, i+1)))
      loop(i + 2, list, map)
    else
      map
    end
  end

  def get(username) do
    Agent.get(@name, fn users ->
      Map.get(users, username) end)
  end


end
