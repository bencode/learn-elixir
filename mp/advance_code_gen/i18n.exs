defmodule I18n do
  use Translator

  locale "en",
    flash: [
      hello: "Hello %{first} %{last}",
      bye: "Bye, %{name}"
    ],
    users: [
      title: "Users"
    ]

  locale "fr",
    flash: [
      hello: "Salut %{first} %{last}",
      bye: "An revoir, %{name}!"
    ],
    users: [
      title: "Utilisateurs"
    ]
end
