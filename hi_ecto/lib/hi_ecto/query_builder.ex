defmodule HiEcto.QueryBuilder do
  def build(expr) when is_binary(expr) do
    tokens =
      expr
      |> String.split(~r/[()\s]/, include_captures: true)
      |> Enum.reject(&(&1 =~ ~r/^\s*$/))

    IO.inspect expr
    expr = parse_expr(tokens |> Enum.drop(-1))
    fun = Enum.at(tokens, -1)
    IO.inspect expr
  end

  # expr -> group_expr | or_expr
  # group_expr -> (expr)
  # or_expr ->
  #   group_expr [or or_expr]
  #   and_expr [or or_expr]
  # and_expr ->
  #   group_expr [and and_expr]
  #   selector [and and_expr]

  defp parse_expr(["(" | _] = tokens) do
    parse_group(tokens)
  end
  defp parse_expr(tokens) do
    parse_or(tokens)
  end

  # (expr)
  defp parse_group(["(" | tokens]) do
    {expr, [")" | remain]} = parse_expr(tokens)
    {expr, remain}
  end

  defp parse_or(["(" | _] = tokens) do
    tokens
    |> parse_group
    |> parse_recur(:or, &parse_or/1)
  end
  defp parse_or(tokens) do
    tokens
    |> parse_and
    |> parse_recur(:or, &parse_or/1)
  end

  defp parse_and(["(" | _] = tokens) do
    tokens
    |> parse_group
    |> parse_recur(:and, &parse_and/1)
  end
  defp parse_and(tokens) do
    tokens
    |> parse_selector
    |> parse_recur(:and, &parse_and/1)
  end

  defp parse_selector([selector | remain]) when is_binary(selector) do
    {selector, remain}
  end

  @stop [")", "and", "or"]
  defp parse_recur({left, [op, ahead | remain]}, name, parser) when ahead not in @stop do
    "#{name}" == op
    {right, extra} = parser.([ahead | remain])
    {{name, left, right}, extra}
  end
  defp parse_recur({expr, remain}, _name, _) do
    {expr, remain}
  end

  defp log(v, name) do
    IO.inspect {name, v}
    v
  end
end
