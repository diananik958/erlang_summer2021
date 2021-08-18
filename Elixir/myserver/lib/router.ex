defmodule MYSERVER.Router do
use Plug.Router
use Plug.ErrorHandler
require Logger
@template_dir "html"

    plug :match
    plug :dispatch

    get "/" do
    render(conn, "indexpage.html")
    end

    match _ do
        render(conn, "404.html")
    end


    defp render(%{status: status} = conn, template, assigns \\ []) do
        body =
        @template_dir
        |> Path.join(template)
        |> String.replace_suffix(".html", ".html.eex")
        |> EEx.eval_file(assigns)

        adapter = elem(Map.fetch!(Map.from_struct(conn), :adapter), 1)
        data = [Map.fetch!(adapter, :peer)] ++ [Date.utc_today] ++ [Time.utc_now] ++ [Map.fetch!(adapter, :path)] ++ [Map.fetch!(adapter, :method)]
        Logger.info(Kernel.inspect(data))
        MYSERVER.StartDB.start_db(data)
        send_resp(conn, (status || 200), body)
    end


    defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
        IO.inspect(kind, label: :kind)
        IO.inspect(reason, label: :reason)
        IO.inspect(stack, label: :stack)
        render(conn, "500.html")
      end
end