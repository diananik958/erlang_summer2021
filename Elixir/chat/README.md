# Chat

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `chat` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:chat, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/chat](https://hexdocs.pm/chat).


To start sending messages in two windows of the terminal do:

First: 
$ iex --sname diana@localhost -S mix

Second:
$ iex --sname sasha@localhost -S mix

Command for both:
iex(<name>@localhost)1> Chat.send_msg(:<name>@localhost, "<Your message>")

