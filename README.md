# PI

[![hex.pm version](https://img.shields.io/hexpm/v/ex_pi.svg)](https://hex.pm/packages/ex_pi)

Pretty Inspect pi() function for puts-debugging

## Usage

```elixir
  defmodule MyModule do
    use PI

    def func(variable_name) do
      variable_name
      |> pi()
      |> process_arg()
    end

    # ...
  end
```

Which will output in console, when MyModule.func/1 is called:

```
22:15:58 [my_module.ex:6: MyModule.func/1]
variable_name: "argument_value"
```
