

# systemctl --user stop ssh-agent.service
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
systemctl --user status ssh-agent.service


systemctl --user restart ssh-agent.service
systemctl --user status ssh-agent.service
