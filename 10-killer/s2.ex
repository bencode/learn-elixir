defprotocol Mine do
  def name_for(user)
end

defimpl Mine, for: Any do
  def name_for(user) do
    user.name
  end
end

defmodule User do
  @derive [Mine]
  defstruct [:name]
end
