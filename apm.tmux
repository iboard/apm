#!/usr/local/bin/fish
#
#  Start tmux and execute this script in order
#  to get the testing requirements for APM 
#  up and running in one window. Which is
#
#  1. Start the phoenix server (port 4000)
#  2. Start phantomjs for E2E tests with hound.

# colors
tmx set -g default-terminal "screen-256color"
# # unicode
tmx setw -g utf8 on
tmx set -g status-utf8 on

tmx neww
tmx rename-window "APM-Server"

# CREATE PANES
tmx split-window -l 5
tmx split-window -h -p 50
tmx select-pane -t 0

# PANE 0 (left,top) - Phoenix Server
tmx select-pane -t 1
tmx send-keys "cd ~/dev/apm/elixir/apps/apm_px" C-m
tmx send-keys "mix phoenix.server" C-m

# PANE 2 (left,bottom) - Phantom JS

tmx send-keys "sleep 5" C-m
tmx select-pane -t 2
tmx send-keys "cd ~/dev/apm/elixir/apps/apm_px" C-m
tmx send-keys "phantomjs --wd" C-m

# PANE 4 (right,bottom) - Terminal
tmx send-keys "sleep 5" C-m
tmx select-pane -t 0
tmx send-keys "cd ~/dev/apm/elixir/apps/apm_px" C-m
tmx send-keys "mix test --trace" C-m
