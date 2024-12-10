[{1 :nvim-telescope/telescope.nvim
  :tag :0.1.8
  :dependencies [:nvim-lua/plenary.nvim]}
 ;; file picker
 {1 :nvim-neo-tree/neo-tree.nvim
  :branch :v3.x
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-tree/nvim-web-devicons
                 :MunifTanjim/nui.nvim]}
 ;; editor file browser
 {1 :folke/snacks.nvim
  :priority 1000
  :lazy false
  :opts {:bigfile {:enabled true}
         :dashboard {:enabled true
                     :header ["=================     ===============     ===============   ========  ========"
                              "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //"
                              "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||"
                              "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||"
                              "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||"
                              "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||"
                              "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||"
                              "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||"
                              "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||"
                              "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||"
                              "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||"
                              "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||"
                              "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||"
                              "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||"
                              "||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||"
                              "||.=='    _-'                                                     `' |  /==.||"
                              "=='    _-'                        N E O V I M                         \\/   `=="
                              "\\   _-'                                                                `-_   /"
                              " `''                                                                      ``' "]}
         :notifier {:enabled true}
         :quickfile {:enabled true}
         :statuscolumn {:enabled true}
         :terminal {:enabled true}
         :words {:enabled true}}}
 ;; see enabled modules
 {1 :folke/which-key.nvim :event :VeryLazy :opts {}}
 ;Show keybinds
 ]
