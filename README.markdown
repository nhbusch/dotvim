Installation
============

Follow these steps to install vim plugins and config files:

## Clone repository

```
  git clone git://github.com/nhbusch/dotvim.git ~/.vim
```

*Note*: On Windows, replace `~` with `%HOME%` or `%USERPROFILE%`.

## Create symlinks

On Unix:

```shell
  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/gvimrc ~/.gvimrc
 ```
  
On Windows, assuming Vim is installed to `C:\opt\vim`
  
```
  mklink /H C:\opt\vim\_vimrc %USERPROFILE%\.vim\vimrc
  mklink /H C:\opt\vim\_gvimrc %USERPROFILE%\.vim\gvimrc
```

Note: if the personal runtime directory is assumed to be `vimfiles`,
also create a symbolic link `vimfiles` pointing to `%USERPROFILE%\.vim`:

```
  mklink /J %USERPROFILE%\vimfiles %USERPROFILE%\.vim
```

Switch to the `~/.vim` directory, and fetch submodules:

## Get plugins

```
  cd ~/.vim
  git submodule init
  git submodule update
```
