use Mix.Config

config :logger,
    backends: [:console],
    compile_time_purge_level: :error,
    level: :error

import_config "../apps/*/config/config.exs"

