defprotocol Triple do
  def triple(input)
end

defimpl Triple, for: Integer do
  def triple(int) do
    int * 3
  end
end

defimpl Triple, for: List do
  def triple(list) do
    list ++ list ++ list
  end
end
