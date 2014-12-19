# GNOME Emacs Starterkit — Installation

A basic starter kit for doing GNOME development with Emacs.

This document will initially be pretty Fedora 21 centric (as that's my OS of choice). Patches for other distributions are more than welcome!

## Git

```bash
$ pkcon install git
```

## JavaScript

### Prerequisites

```bash
$ pkcon install nodejs npm
```

### Installation and setup

#### Node.js — Optionally use ~/.local

The Node packages we want to install are meant to be globally installed. If you (like me) feel more comfortable installing custom code to ~/.local/ instead, you need to do the following:

Set up `Node.js` and `npm` to use `~/.local/bin/`

```bash
$ echo "prefix = ${HOME}/.local" >> ~/.npmrc
$ echo "export NODE_PATH=$HOME/.local/lib/node_modules/:\$NODE_PATH" >> ~/.bashrc
$ source ~/.bashrc
```

The rest of the installation document assumes you've completed the steps above. If you don't be prepared to prepend `sudo ` to any `npm install` calls below.

#### Lint and Code style checking

[JSHint][JSHint] and [JSCS][JSCS] provides linting and code style checking for your JavaScript code.

```bash
$ npm install -g jshint jscs
```

## C

### Prerequisites

```bash
$ pkcon install cmake clang-devel llvm-devel llvm-static
```

### Installation and setup

#### RTags

For C (and C++) auto completion, code navigation and such we will go with the excellent [RTags][RTags] code indexer.

###### Get the code

```bash
$ git clone --depth 1 https://github.com/Andersbakken/rtags.git
$ cd rtags
$ git submodule update  --init
$ mkdir build
$ cd build
```

###### Build and Install

```bash
$ cmake -DCMAKE_INSTALL_PREFIX:PATH="${HOME/.local/}" .. && make && make install
```

Or if you prefer a global installation: 

```bash
$ cmake .. && make && make install
```

###### Automatic CFlags discovery

From the [RTags `README.md`][RTags]:

	Since clang requires us to really compile the file we need to know the
	actual c(xx)flags for the source files. In essence RTags indexes all the
	source files it has been told about and all the headers included by these
	source files. [...]

The best way to automate this (and the way described in the [RTags][RTags] documentation) is to wrap `gcc` in a helper script provided by [RTags][RTags]:

```bash
$ # Assuming pwd is still <path/to/rtags/build/>
$ install -m 755 "../bin/gcc-rtags-wrapper.sh" ~/.local/bin/
$ cd ~/.local/bin/
$ for cc in "gcc" "g++" "cc" "c++"; do ln -s gcc-rtags-wrapper.sh "${cc}"; done
```

## Emacs

### Preparation

###### Backup

Let's be safe and backup our previous emacs configuration.

```bash
$ mkdir ~/Documents/emacs-backup/
$ mv ~/.emacs ~/.emacs.d ~/Documents/emacs-backup/
```

###### GNOME Emacs Starterkit

This is the repository you're reading from right now.

```bash
$ git clone https://github.com/moonlite/gnome-emacs-starterkit.git ~/.emacs.d
$ cd ~/.emacs.d
$ git submodule update --init
```

###### Cask

[Cask][Cask] is a project management tool for Emacs Lisp and will help us install all
Emacs packages that we need.

```bash
$ ln -s ~/.emacs.d/site-lisp/cask/bin/cask ~/.local/bin/cask
```

### Installation

Now we just use Cask to install our emacs packages for us.

```bash
$ cd ~/.emacs.d
$ cask install
```

[RTags]: https://github.com/Andersbakken/rtags "RTags"

[JSHint]: http://jshint.com/ "JSHint"

[JSCS]: https://github.com/jscs-dev/node-jscs "JSCS"

[Cask]: https://github.com/cask/cask "Cask"

[gnome-emacs-starterkit]: https://github.com/moonlite/gnome-emacs-starterkit "GNOME Emacs Startkit"
