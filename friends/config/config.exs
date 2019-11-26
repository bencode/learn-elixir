import Config

config :friends, ecto_repos: [Friends.Repo]

config :friends, Friends.Repo,
  database: "friends_dev",
  username: "friends",
  password: "friends",
  hostname: "localhost",
  port: 15433

