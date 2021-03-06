defmodule UserAgent do
  @moduledoc """
  User agent
  """
  require Logger

  use Agent

  @name {:global, __MODULE__}

  def start_link do
    Agent.start_link(fn -> [] end, name: @name)
  end

  def start_link([]) do
    Agent.start_link(fn -> [] end, name: @name)
  end

end
