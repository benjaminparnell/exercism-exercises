defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare([], []), do: :equal
  def compare([], b), do: :sublist
  def compare(a, []), do: :superlist
  def compare(a, b) do
    # This approach while it looks ugly is much faster than not swapping.
    swapped = false
    if length(a) > length(b) do
      [a, b] = [b, a]
      swapped = true
    end

    cond do
      a == b -> :equal
      is_sublist?(a, b) && !swapped -> :sublist
      is_sublist?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp is_sublist?(a, b) do
    0..(length(b) + 1 - length(a)) |> Enum.any?(fn (x) -> Enum.slice(b, x, length(a)) === a end)
  end
end
