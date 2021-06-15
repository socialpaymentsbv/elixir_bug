defmodule BugTest do
  use ExUnit.Case
  doctest Bug

  test "this test fails every couple of runs" do
    for x <- 1..1000 do
      {:ok, m} = Money.cast(%{amount: "10.00", currency: "EUR"})
    end
  end
end
