defmodule HiEcto.QueryBuilder do
  import Ecto.Query

  def build(module, expr, value) when is_binary(expr) do
    %{expr: expr, fun: fun} = parse(expr)
    joins = get_joins(expr)
    IO.inspect joins

    query = from self in module
    query =
      joins
      |> Enum.reduce(query, fn table, acc ->
        join(acc, :inner, [...,p1], p2 in assoc(p1, ^table))  # 这里的p1,p2需要调整，我搞得不是很明白
      end)
      |> build_where(expr, fun, value)
  end

  def parse(expr) do
    tokens =
      expr
      |> String.split(~r/[()\s]/, include_captures: true)
      |> Enum.reject(&(&1 =~ ~r/^\s*$/))

    {expr, []} = parse_expr(tokens |> Enum.drop(-1))
    fun = Enum.at(tokens, -1)
    %{expr: expr, fun: fun}
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
    |> parse_recur("or", &parse_or/1)
  end
  defp parse_or(tokens) do
    tokens
    |> parse_and
    |> parse_recur("or", &parse_or/1)
  end

  defp parse_and(["(" | _] = tokens) do
    tokens
    |> parse_group
    |> parse_recur("and", &parse_and/1)
  end
  defp parse_and(tokens) do
    tokens
    |> parse_selector
    |> parse_recur("and", &parse_and/1)
  end

  defp parse_selector([selector | remain]) when is_binary(selector) do
    {{:selector, transform_selector(selector)}, remain}
  end

  @stop [")", "and", "or"]
  defp parse_recur({left, [op, ahead | remain]}, name, parser)
  when op == name and ahead not in @stop do
    {right, extra} = parser.([ahead | remain])
    {{:"#{name}", left, right}, extra}
  end
  defp parse_recur({expr, remain}, _name, _) do
    {expr, remain}
  end

  defp transform_selector(selector) do
    parts = String.split(selector, ~r/\./)
    joins =
      parts
      |> Enum.drop(-1)
      |> Enum.map(fn table -> :"#{table}"
      end)
    namespace = length(parts) > 1 && Enum.at(parts, -2) || nil
    field = parts |> Enum.at(-1)
    %{joins: joins, field: field, namespace: namespace}
  end

  defp get_joins(expr) do
    expr |> get_joins_inner |> Enum.uniq
  end
  defp get_joins_inner({op, left, right}) when op in [:and, :or] do
    get_joins_inner(left) ++ get_joins_inner(right)
  end
  defp get_joins_inner({:selector, %{joins: joins}}) do
    joins
  end

  defp build_where(query, expr, fun, value) do
    #build_where(left, fun, value) or build_where(right, fun, value)
    query
  end
end
