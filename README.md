dotfiles
========

just another dotfile repo, inspired by [dotfiles](http://dotfiles.github.com/) and [michael smalley](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) this is my part. 

howto use
==========

you should have installed

* git
* rake
* bash-completion
* vim-nox 

On Debian/Ubuntu: `apt-get install git rake bash-completion vim-nox` (newer Version)

Ubuntu Lucid: `apt-get install git-core rake bash-completion vim-nox`

Ubuntu Hardy you need to Update GIT before (best via ppa): 
`apt-get install python-software-properties && dpkg-reconfigure python-software-properties && add-apt-repository ppa:git-core/ppa && apt-get update && apt-get install git` 

after this you need to disable SSL Verification `export GIT_SSL_NO_VERIFY=true` and then you can clone and install. But you might need to disable some janus modules (vim 7.2 is the Version here)


If you got a _rake_ Error from Janus Install you should install `libopenssl-ruby1.8`


After you got a clone with `git clone git://github.com/jalogisch/dotfiles.git --recursiv` just type in `bash -x install.sh` after you `cd dotfiles`.
VIM
===

I use [janus](https://github.com/carlhuda/janus) for my vim Setup, so you should take a look there how to customize it to your needs.
