# PI

Pretty Inspect pi() function for puts-debugging

## Usage

```elixir
  defmodule MyModule do
    use PI

    def func(arg) do
      arg
      |> pi()
      |> process_arg()
    end

    # ...
  end
```

Which will output in console, when MyModule.func/1 is called:

```
22:15:58 [my_module.ex:6: MyModule.func/1]
arg: "argument_value"
```
