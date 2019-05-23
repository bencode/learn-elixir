# EEx

https://hexdocs.pm/eex/master/EEx.html


## API

- `eval_string`, `eval_file` 可用，慢。
- `function_from_string`, `function_from_file`， 建议
- `compile_string`, `compile_file` 高级，可自定义

## Engine

可自定义转换的引擎，默认为 `EEx.SmartEngine`


### Tags

```eex
<% Elixir expression %>
<%= Elixir expression %>
<%% EEx quotation %%>
<%# 注释 %
```

`everytihing in elixir is an expression`


### Macros

```elixir
iex> EEx.eval_string("<%= @foo %>", assigns: [: 1])
```

`<%= @foo %>` 相当于

```elixir
<%= {:ok, v} = Access.fetch(assigns, :foo); v %>
```

这真是一个好技巧

v = 


