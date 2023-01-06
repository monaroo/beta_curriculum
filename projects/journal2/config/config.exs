import Config

config :journal2, ecto_repos: [Journal.Repo]

config :journal2, Journal.Repo,
  database: "journal2_repo",
  username: "mona",
  password: "1l0v3unwichesz",
  hostname: "localhost"
