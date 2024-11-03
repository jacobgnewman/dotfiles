if status is-interactive
    # Commands to run in interactive sessions can go here

    # config atuin hooks
    atuin init fish | source
    alias cat bat
    alias vim nvim
end

# remove fish greeting prompt
set fish_greeting
