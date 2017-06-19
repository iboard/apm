# ApmPx

Please start at the README.md in the root folder of the project.

Further documentation can be created by

  1. cd PROJECT_ROOT/elixir
  2. mix docs
  3. open doc/index.html


## Run unit tests from this folder

  1. mix test --exclude hound --trace

## Running Hound Integration tests from this folder

  1. Start the server with mix phoenix.server (default on port 4000)
  2. Run mix test --only hound
