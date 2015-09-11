defmodule RopTest do
  use ExUnit.Case
  use Rop

  test "Count to 3" do
    assert (ok(0) >>> ok >>> ok) == {:ok, 3}
  end

  test "Error" do
    assert (ok(0) >>> error) == {:error, "Error at 1"}
  end

  test "Error propagation" do
    assert (ok(0) >>> error >>> ok) == {:error, "Error at 1"}
  end

  defp ok(cnt) do
    {:ok, cnt + 1}
  end

  defp error(cnt) do
    {:error, "Error at #{cnt}"}
  end
end
