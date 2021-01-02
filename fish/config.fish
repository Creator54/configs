set fish_greeting
set configd "~/.config/fish"
set config "$configd/config.fish"

# add new alias
function lalias --argument key value
  echo alias $key=$value
  alias $key=$value
  funcsave $key
end

# remove an alias
# currently removes everyline matching the argument
#function ralias
#  if ! rm $configd/functions/$argv.fish
#    grep -v "$argv" $config > $configd/tmp
#    mv $config $config.bak && mv tmp $config
#  end
#end

# undo config change
function uconfig
  if [ -f $config.bak ]
    rm $config && mv $config.bak $config 
  end
end

# vim/neovim
function v
  if which vim &> /dev/null
    vim $argv;
  else if which nvim &> /dev/null
    nvim $argv;
  end
end

# install packages
function installp
  if ! nix-env -iA nixos.$argv || nix-env -iA nixpkgs.$argv
    echo "Please check the package name"
  end
end

# remove packages
function removep
  set cmd "nix-env -q | grep $argv"
  if fish -c $cmd &>/dev/null
    fish -c $cmd | xargs nix-env --uninstall ;
  end
end

#some default aliases
alias c="cd ../"
alias p="nix-env -q"
alias i="installp"
alias r="removep"
alias s="nix search"
alias fishd="cd $configd"
alias fishc="vim ~/.config/fish/config.fish"
