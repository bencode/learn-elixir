defmodule UseGuards do
  defguard is_even(n) when is_number(n) and rem(n, 2) == 0

  def main() do
    IO.inspect foo(123)
    IO.inspect bar("345")
  end

  def foo(term) when is_integer(term) or is_float(term) or is_nil(term) do
    :maybe_number
  end

  def foo(_other) do
    :something_else
  end

  # 如果每个条件都仅返回boolean，而不raise exception，上面语句相当于下面的语句
  # 上面的条件可以简化成下面的语句
  def bar(term)
      when is_integer(term)
      when is_float(term)
      when is_nil(term) do
    :maybe_number
  end

  def bar(_other) do
    :something_else
  end
end



UseGuards.main()
