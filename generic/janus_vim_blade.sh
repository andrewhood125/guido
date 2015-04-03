_janus_vim_blade_installed() {
  if [[ -d "${HOME}/.janus/vim-blade" ]] ; then
    return 0;
  fi
  return 1;
}

_janus_vim_blade_up() {
  eval "git clone https://github.com/xsbeats/vim-blade.git ${HOME}/.janus/vim-blade"
}
