defmodule MYSERVER.StartDB do
require Logger

    def start_db(raw_data) do
        Logger.info("Connected to database")
        MYSERVER.Database.init(raw_data)
        #doc |> xpath(~x"//header", message: ~x"./p/text()", a_in_li: ~x".//li/a/text()"l)
        #doc
      end
end