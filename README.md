# APM – The Agile Project Manager

## Reasons why this project was started

  - Jira sux
  - I'm on vacation and I need to do some fun stuff
  - Practicing with Elixir and Phoenix

## Prerequisites

  - Erlang and Elixir is installed – see [Elixir-Getting Started][]
  - Basic knowledge of [Elixir][] and [Phoenix][] 
  - Basic knowledge about what '[Umbrella][]' means in Elixir

## Project Structure and Subdirectories

### ./elixir

The elixir umbrella application includes the following applications

  * apm_px - Phoenix Front- and Backend
  * apm_issues - define, manipulate, and persistent (Jira)Issues
  * apm_user - functions for user, role, ...

#### Quick start developing 

  * cd into `elixir/apps/apm_px`
  * start the server with `mix phoenix.server` (in an extra terminal window)
    - now you can open the frontend in your browser `http://localhost:4000`
  * start `phantomjs --wd` (in an extra terminal window)
  * run the tests in path `elixir` with `mix test --trace`
  * run only the unit-tests without E2E `mix test --trace --exclude hound`

#### Start development- and testing-environment with tmux and fish-shell

If you a TMUX-user, you can start all of the stuff mentioned above with
a single command `apm.tmux`

  * cd into the project's root
  * start your tmux
  * execute apm.tmux
    - It starts the phoenix server
    - it runs phantomjs for hound testing


### ./aurelia-frontend

Just another frontend to give feedback for developers about how the APM
backend in ./elexir can be used.


[Elixir]: https://elixir-lang.org
[Elixir-Getting Started]: https://elixir-lang.org/getting-started/introduction.html
[Phoenix]: http://www.phoenixframework.org
[Umbrella]: https://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-apps.html#umbrella-projects
