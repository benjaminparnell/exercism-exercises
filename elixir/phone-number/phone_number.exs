defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t) :: String.t
  def number(raw) do
    cleaned = String.replace(raw, ~r/[-()\s.]/, "", global: true)

    if String.starts_with?(cleaned, "1") && String.length(cleaned) == 11 do
      cleaned = String.slice(raw, 1, String.length(cleaned))
    else
      if String.length(cleaned) == 11 || String.length(cleaned) == 9 do
        cleaned = "0000000000"
      end
    end

    if String.match?(cleaned, ~r/[A-Za-z]/) do
      cleaned = "0000000000"
    end

    cleaned
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    cleaned = number(raw)
    String.slice(cleaned, 0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    cleaned = number(raw)
    code = "(" <> area_code(cleaned) <> ")"
    rest = String.split_at(elem(String.split_at(cleaned, 3), 1), 3)

    code <> " " <> Enum.join([elem(rest, 0), elem(rest, 1)], "-")
  end
end
