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

[{1 :folke/which-key.nvim :opts {}}]
