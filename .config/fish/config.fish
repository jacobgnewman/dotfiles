if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
    starship init fish | source
    thefuck --alias | source
    
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval /home/gray/miniconda3/bin/conda "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end

function fish_greeting

end

function home
    cd ~
end

function ls
    exa $argv
end

function cat
    bat $argv
end

function fuck
    thefuck $argv
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/gray/code/tools/google-cloud-sdk/path.fish.inc' ]; . '/home/gray/code/tools/google-cloud-sdk/path.fish.inc'; end

