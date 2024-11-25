(macro sparse [...]
  (let [args [...]
        t {}]
    (for [i 1 (length args) 2]
      (let [key (. args i)
            val (. args (+ i 1))]
        (if (= key `&i)
            (table.insert t val)
            (tset t key val))))
    t))

[{1 :nvim-telescope/telescope.nvim
  :tag :0.1.8
  :dependencies [:nvim-lua/plenary.nvim]}
 {1 :nvim-neo-tree/neo-tree.nvim
  :branch :v3.x
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-tree/nvim-web-devicons
                 :MunifTanjim/nui.nvim]}
 {1 :folke/snacks.nvim
  :priority 1000
  :lazy false
  :opts {:bigfile {:enabled true}
         :dashboard {:enabled true}
         :notifier {:enabled true}
         :quickfile {:enabled true}
         :statuscolumn {:enabled true}
         :terminal {:enabled true}
         :words {:enabled true}}}
 {1 :folke/which-key.nvim :event :VeryLazy :opts {}}]
