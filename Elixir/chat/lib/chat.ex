defmodule Chat do
  @moduledoc 

  def receive_msg(msg) do
	IO.puts msg
  end
  
  def send_msg(recipient, msg) do
  	spawn_task(__MODULE__, :receive_msg, recipient, [msg])
  end
  
  def spawn_task(module, fun, recipient, args) do
  	recipient
  	|> remote_supervisor()
  	|> Task.Supervisor.async(module, fun, args)
  	|> Task.await()
  end
  
  def remote_supervisor(recipient) do
	{Chat.TaskSupervisor, recipient}
  end
end
