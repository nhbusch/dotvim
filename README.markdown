Installation
============

Clone repository

  git clone git://github.com/nhbusch/dotvim.git ~/.vim

Note: On Windows, replace `~` with `%HOME%` or `%USERPROFILE%`.

Create symlinks

* On *nix:

::

  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/gvimrc ~/.gvimrc
  
* On Windows, assuming Vim is installed to `C:\opt\vim`
  
::

  mklink /H C:\opt\vim\_vimrc %USERPROFILE%\.vim\vimrc
  mklink /H C:\opt\vim\_gvimrc %USERPROFILE%\.vim\gvimrc

* Switch to the `~/.vim` directory, and fetch submodules:

::

  cd ~/.vim
  git submodule init
  git submodule update
