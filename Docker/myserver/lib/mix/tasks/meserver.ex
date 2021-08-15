defmodule Mix.Tasks.Myserver do
  use Mix.Task

  @shortdoc
  
  @moduledoc """
  A mix custom task that starts my web-server
  """
  
  def run(_) do
    MYSERVER.start()
  end
end
