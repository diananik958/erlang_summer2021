defmodule MYSERVER.Parse do
    require Logger
    def parse(data) do
        Logger.info("data for parsing")
        Logger.info(Kernel.inspect(Enum.at(data, 2)))
        time = Enum.join([Kernel.inspect(Enum.at(data, 2).hour), Kernel.inspect(Enum.at(data, 2).minute), Kernel.inspect(Enum.at(data, 2).second)], ":")
        Logger.info(Kernel.inspect(time))
        date = Enum.join([Kernel.inspect(Enum.at(data, 1).year), Kernel.inspect(Enum.at(data, 1).month), Kernel.inspect(Enum.at(data, 1).day)], "-")
        Logger.info(Kernel.inspect(date))
        {ip, port} = Enum.at(data, 0)
        Logger.info(Kernel.inspect(ip))
        Logger.info(Kernel.inspect(port))
        new_data = [Kernel.inspect(ip), port, date, time, Enum.at(data, 3), Enum.at(data, 4)]
        Logger.info(Kernel.inspect(new_data))
        new_data
    end

end

#[{{192, 168, 1, 49}, 58670}, ~D[2021-08-18], ~T[10:43:46.444914], "/", "GET"]

#[{192, 168, 1, 49}, 58670, 2021-08-18, 10:43:46, /, GET]