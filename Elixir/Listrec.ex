defmodule Listrec do 
#Обход по списку, выводим новый список, где к каждому элементу прибавляется один
    defp createlist() do
        [1, 3, 5, 78, 98, 35, 12, 34, 58, 23, 554, 21, 0, 287]
    end

    defp recTrav([head|tail], new) do
        newlist = new ++ [head + 1]
        recTrav(tail, newlist)
    end

    defp recTrav([], new) do
        new
    end

    def recutsiveTraversal() do
        list = createlist()
        new = []
        IO.puts("Starting")
        recTrav(list, new)
    end
end