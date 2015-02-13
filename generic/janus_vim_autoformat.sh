echo -e "\t${BASH_SOURCE}"
autoformat_dir="${HOME}/.janus/vim-autoformat"
_janus_vim_autoformat_installed() {
  if [[ -d "${autoformat_dir}" ]] ; then
    return 0;
  fi
  return 1;
}

_janus_vim_autoformat_up() {
  `git clone https://github.com/Chiel92/vim-autoformat.git ${autoformat_dir}`
}

_janus_vim_autoformat() {
  if _janus_vim_autoformat_installed ; then
    echo -e "\talready installed."
  else
    _janus_vim_autoformat_up
  fi
}