# arthurnn’s dotfiles

## Fork

This is not a full fork, but was havily based on dotfiles from [mathiasbynens](https://github.com/mathiasbynens/dotfiles).


## Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/dev/dotfiles`) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/arthurnn/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```


#### Bash

In OSX you need to require bashrc from a bash_profile file. You can add more OSX configs to the bash_profile file if needed. i.e:


```bash
# ~/.bash_profile
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
```
