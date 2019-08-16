if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi
export SSH_AUTH_SOCK=~/.ssh/auth_sock
if ! fuser "$SSH_AUTH_SOCK" >/dev/null 2>/dev/null; then
  # Nothing has the socket open, it means the agent isn't running
  ssh-agent -a "$SSH_AUTH_SOCK" -s >~/.ssh/agent-info
fi
