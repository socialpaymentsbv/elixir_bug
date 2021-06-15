defmodule Money do
  defstruct cents: 0, currency: nil

  def cast(%{"cents" => cents, "currency" => currency}) do
    cast(%{cents: cents, currency: currency})
  end

  def cast(%{"amount" => amount, "currency" => currency}) do
    cast(%{amount: amount, currency: currency})
  end

  def cast(%{amount: nil}) do
    {:ok, nil}
  end

  def cast(%{amount: amount, currency: currency})
      when is_binary(amount) and is_binary(currency) do
    case Money.parse("#{amount} #{currency}") do
      {:error, _} -> :error
      money -> money
    end
  end

  def cast(%Money{} = m), do: {:ok, m}

  def cast(%{cents: cents, currency: currency})
      when is_integer(cents) and is_binary(currency) do
    {:ok, %Money{cents: cents, currency: currency}}
  end

  def parse(str) when is_binary(str) do
    IO.inspect(str, label: "STR")
    lst = Regex.split(~r/\s+/, String.trim(str))
    IO.inspect(lst, label: "LST")
    [currency | rest] = Enum.reverse(lst)
    value = rest |> Enum.reverse() |> Enum.join()
    IO.inspect(value, label: "VALUE")

    case parse_amount(value) do
      cents when is_integer(cents) ->
        {:ok, %Money{cents: cents, currency: currency}}

      {:error, _} = error ->
        error
    end
  end

  def parse_amount("") do
    {:error, :invalid_amount}
  end

  def parse_amount(_) do
    1000
  end

  def to_string(_) do
    "nvm"
  end
end

defimpl Inspect, for: Money do
  def inspect(money, _opts) do
    "~M\"#{money}\""
  end
end

defimpl String.Chars, for: Money do
  defdelegate to_string(data), to: Money
end
