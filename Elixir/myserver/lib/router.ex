defmodule Router do
use Plug.Router
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
    
        send_resp(conn, (status || 200), body)
    end
end