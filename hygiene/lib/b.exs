ast = quote do
  if var!(meaning_to_life) == 42 do
    "it's true"
  else
    "it remains to be seen"
  end
end


Code.eval_quoted ast, meaning_to_life: 42
#Code.eval_quoted ast, meaning_to_life: 100

