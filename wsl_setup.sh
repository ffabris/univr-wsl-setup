#!/usr/bin/env bash

if [ "$(id -u)" = 0 ]; then
  echo -n "This script must not be launch as root; "
  echo "single commands will ask for root privileges."
  exit 1
fi

echo "Preparing installation of packages..."

# Refresh package lists
sudo apt-get update -qq || exit

# Set up the list of packages to install
apt_pkgs=(
  build-essential
  cgdb
  cmake
  git
  manpages-posix-dev
  qemu-system-x86
  wslu
  xterm
)

# Install the listed apt packages
sudo apt-get install -qy "${apt_pkgs[@]}" || exit

# Append X configuration settings to bashrc and zshrc (if zsh is available)
rc_paths="${HOME}/.bashrc"
if grep -q "zsh" /etc/shells; then
  rc_paths="${rc_paths} ${HOME}/.zshrc"
fi

# Display Setting: https://wiki.ubuntu.com/WSL#Running_Graphical_Applications
display=":0"
if [[ $(uname -r) =~ WSL2 ]]; then
  display="\$(awk '/nameserver / {print \$2; exit}' /etc/resolv.conf 2>/dev/null)${display}"
fi

echo
for rc_file in $rc_paths; do
  echo -n "Appending X support to ${rc_file} ... "
  tee -a "$rc_file" << EOF > /dev/null
# X11 support for WSL
export DISPLAY=${display}
export LIBGL_ALWAYS_INDIRECT=1
EOF
  echo "done."
done

# Append X configuration settings to config.fish (if fish is available)
if grep -q "fish" /etc/shells; then
  rc_file="${HOME}/.config/fish/fish_variables"
  echo -n "Appending X support to ${rc_file} ... "
  tee -a "$rc_file" << EOF > /dev/null
SETUVAR --export DISPLAY:${display}
SETUVAR --export LIBGL_ALWAYS_INDIRECT:1
EOF
  echo "done."
fi

# You're good to go now!
echo -e "\nTweaking of WSL completed.\n"
