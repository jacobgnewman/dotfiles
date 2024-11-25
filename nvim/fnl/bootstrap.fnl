(fn bootstrap-lazy []
  "A function to install lazy.nvim if not currently installed where vim expects it"
  (let [fsm (or vim.uv vim.loop)
        lazypath (.. (vim.fn.stdpath :data) :/lazy/lazy.nvim)
        lazyrepo "https://github.com/folke/lazy.nvim.git"]
    (if (not (fsm.fs_stat lazypath))
        (let [out (vim.fn.system [:git
                                  :clone
                                  "--filter=blob:none"
                                  :--branch=stable
                                  lazyrepo
                                  lazypath])]
          (if (not= vim.v.shell_error 0)
              ((vim.api.nvim_echo [["Failed to clone lazy.nvim:\n" :ErrorMsg]
                                   [out :WarningMsg]
                                   ["\nPress any key to exit..."]]
                                  true {}) (vim.fn.getchar) (os.exit 1)))))
    (vim.opt.rtp:prepend lazypath)))
