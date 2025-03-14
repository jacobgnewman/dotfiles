if status is-interactive
    # Commands to run in interactive sessions can go here

    # config atuin hooks
    atuin init fish --disable-up-arrow | source
    alias cat bat
    alias vim nvim

end

# set --universal pure_enable_single_line_prompt true
set --universal pure_show_system_time true
set --universal pure_color_system_time pure_color_normal

# shorten output
#set pure_shorten_prompt_current_directory_length 1
#set pure_truncate_prompt_current_directory_keeps 0

# remove fish greeting prompt
set fish_greeting

function cfg 
  cd ~/dotfiles
  nvim
end

function cdpwn
  pushd ~/ctf/pwndock/
  if not docker ps --format '{{.Names}}' | grep -q "^pwn_container"
    echo "Starting pwn container"
    ./start.sh
    sleep 0.5
  end
  ./connect.sh
  popd
end
