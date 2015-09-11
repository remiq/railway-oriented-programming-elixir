defmodule Rop do
  defmacro __using__(_) do
    quote do
      defmacro left >>> right do
        quote do
          (fn ->
            case unquote(left) do
              {:ok, x} -> x |> unquote(right)
              expr -> expr
            end
          end).()
        end
      end
    end
  end
end
