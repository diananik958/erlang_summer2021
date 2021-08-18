defmodule MYSERVER.Database do
  require Logger

    def start_link(options) do
        MyXQL.start_link(options)
      end
    
    def init(raw_data) do
        data = MYSERVER.Parse.parse(raw_data)
        res =
          MyXQL.query!(
            :myxql,
            "CREATE TABLE IF NOT EXISTS elixir (IP VARCHAR(255), Port INT, Date DATE, Time TIME, Path VARCHAR(255), Method VARCHAR(255));"
          )
          MyXQL.query!(
            :myxql, 
            "INSERT INTO elixir VALUES (?, ?, ?, ?, ?, ?)", data
            )
        {res, :myxql}
    end


end