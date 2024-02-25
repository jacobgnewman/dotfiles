#!/user/bin/bash

# credit https://github.com/justrowingby/dotfiles/blob/mainline/dotfiles.sh
set -euxo pipefail

scriptdir=$(cd "$(dirname -- "$0")" ; pwd -P)
echo "scriptdir: ${scriptdir}"

function link_config_dir() {
		if [[ -e "$2" && ! -L "$2" ]] ; then 
			echo "$2 exists and is not a symlink. not replacing." >&2
		  return 0
		fi
		# "ln -sf source link" follows symlinks by default on ancient BSD (thus on macOS)
    # the fix on ancient BSD is to add -h, which doesn't exist on GNU ln bc it simply does the reasonable thing in the first place
    # thus for this to be portable we have to implement -f ourselves
    [[ -L "$2" ]] && rm "$2"
    
    ln -sv "${scriptdir}/$1" "$2"
}

mkdir -p ~/.config
link_config_dir alacritty ~/.config/alacritty
link_config_dir helix ~/.config/helix
link_config_dir git ~/.config/git
link_config_dir tmux ~/.config/tmux
