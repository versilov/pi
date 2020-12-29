defmodule PI do
  @moduledoc """
  How to use:

  defmodule MyModule do
    use PI

    def func(arg) do
      arg
      |> pi()
      |> process_arg()
    end
  end
  """
  defmacro __using__(_) do
    quote do
      import(PI)
    end
  end

  require Logger

  @default_options [
    pretty: true,
    syntax_colors: [
      number: :red,
      atom: :cyan,
      string: :green,
      binary: :yellow,
      map: :light_yellow,
      tuple: :white,
      regex: :blue,
      list: :white
    ]
  ]

  def default_options, do: @default_options

  @doc """
  Gorgeous post_inspect function, with colorful formatting and calling point printing
  If no label was given, inspected variable name is used as label.

  `object` — the value to inspect

  `label` — optional label, if `nil`, variable name or expression will be used as label

  `options` — options of `IO.inspect/2`, like `limit: :infinity`

  """
  defmacro pi(object, label \\ nil, options \\ []) do
    do_pi(object, label || Macro.to_string(object), __CALLER__, options)
  end

  def do_pi(object, label, caller, options \\ []) do
    %{module: mod, function: fun, file: file, line: line} = caller
    mod = to_string(mod) |> String.replace_prefix("Elixir.", "")
    fun = to_string(elem(fun, 0)) <> "/" <> to_string(elem(fun, 1))
    file = String.replace_prefix(file, File.cwd!() <> "/", "")
    line = to_string(line)

    prefix =
      " #{IO.ANSI.yellow()}[#{file}:#{line}: #{mod}.#{fun}]\n#{
        IO.ANSI.bright() <> IO.ANSI.white() <> IO.ANSI.color_background(0, 0, 2)
      }"

    quote do
      IO.inspect(
        unquote(object),
        [label: "\n" <> timestamp() <> unquote(prefix) <> unquote(label) <> IO.ANSI.reset()] ++
          default_options() ++ unquote(options)
      )
    end
  end

  def format_log(_level, message, _timestamp, md) do
    file = String.split(md[:file], "/") |> List.last()
    "\n[#{md[:module]}.#{md[:function]}, #{file}:#{md[:line]}]\n#{message}"
  end

  defmacro log(object, label \\ nil) do
    quote do
      label = if unquote(label), do: unquote(label) <> ": ", else: ""

      message = label <> to_inspect_string(unquote(object))

      Logger.warn(message)

      unquote(object)
    end
  end

  def to_inspect_string(object) do
    opts = struct(Inspect.Opts, @default_options)

    object
    |> Inspect.Algebra.to_doc(opts)
    |> Inspect.Algebra.format(80)
    |> Enum.join()
  end

  def timestamp() do
    with {_date, time} <- :calendar.local_time(),
         {:ok, ex_time} <- Time.from_erl(time),
         do: Time.to_string(ex_time)
  end
end

# defmodule XP do
#   import PI

#   defdelegate pi(object, label \\ "", options \\ []), to: PI
# end
