defmodule BugTest do
  use ExUnit.Case
  doctest Bug

  test "this equivalent always works" do
    for x <- 1..1000 do
      {:ok, m} = Money.cast(%{amount: "10.00", currency: "EUR"})
    end
  end
end
