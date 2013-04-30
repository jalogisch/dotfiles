dotfiles
========

just another dotfile repo, inspired by [dotfiles](http://dotfiles.github.com/) and [michael smalley](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/) this is my part.

howto use
==========

you should have installed

* git
* curl
* bash-completion

On Debian/Ubuntu: `apt-get install git rake bash-completion vim` (newer Version)
(on Debian Squeeze best Performance with vim from Backports)

Ubuntu Lucid: `apt-get install git-core bash-completion vim`

Ubuntu Hardy you need to Update GIT before (best via ppa):
`apt-get install python-software-properties && dpkg-reconfigure python-software-properties && add-apt-repository ppa:git-core/ppa && apt-get update && apt-get install git`

after this you need to disable SSL Verification `export GIT_SSL_NO_VERIFY=true` and then you can clone and install. But you might want to Update to Vim 7.3 (or disable some Modules)


After you got a clone with `git clone git://github.com/jalogisch/dotfiles.git --recursiv` just type in `bash -x install.sh` after you `cd dotfiles`.
VIM
===

I switch from [Janus](https://github.com/carlhuda/janus) to [spf13-vim](https://github.com/spf13/spf13-vim), just take a look.
