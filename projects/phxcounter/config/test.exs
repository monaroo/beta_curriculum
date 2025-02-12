import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phxcounter, PhxcounterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "9yLT0D9DgcHszuLKp8yH5F+atquRLl7uRb5fx81oyYj7Z9aqZELrwChz77tGWFxX",
  server: false

# In test we don't send emails.
config :phxcounter, Phxcounter.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
