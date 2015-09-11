Railway oriented programming
===

Implementation of module described here:
http://zohaib.me/railway-programming-pattern-in-elixir/

Same thing can be achieved using Error monad:
http://zohaib.me/monads-in-elixir-2/

## tl;dr

Instead of `|>` we can use `>>>` to pipe `{:ok, val} | {:error, error}` returning functions.

## Usage

As written in `test/rop_test.exs`:

    use Rop

Using Rop defines `>>>` operator.

    test "Count to 3" do
      assert (ok(0) >>> ok >>> ok) == {:ok, 3}
    end

We increase `0` three times to end up with `{:ok, 3}`.

    test "Error" do
      assert (ok(0) >>> error) == {:error, "Error at 1"}
    end

Error function always return error.

    test "Error propagation" do
      assert (ok(0) >>> error >>> ok) == {:error, "Error at 1"}
    end

Error was propagated and second `ok` was not called.

    test "First error is returned" do
      assert (ok(0) >>> error >>> error) == {:error, "Error at 1"}
    end

Only first error is returned, since next `error` is never called.

    defp ok(cnt) do
      {:ok, cnt + 1}
    end

`ok/1` function takes value and increases it, returning standard `{:ok, val}` response.

    defp error(cnt) do
      {:error, "Error at #{cnt}"}
    end

`error/1` function takes value and returns standard `{:error, string}` that identifies where error was called.


