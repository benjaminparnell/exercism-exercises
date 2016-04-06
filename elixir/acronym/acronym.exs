defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
   Regex.split(~r/[\s-]/, string)
   |> Enum.map(fn word -> [String.at(word, 0), Enum.drop(Regex.scan(~r/[A-Z]/, word), 1)] end)
   |> List.flatten
   |> Enum.map(&(String.upcase(String.at(&1, 0))))
   |> Enum.join("")
  end
end
