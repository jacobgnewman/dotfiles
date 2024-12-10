[{1 :Olical/conjure
  :dependencies [:PaterJason/cmp-conjure]
  :ft [:clojure :fennel :python :racket :rust]
  :lazy true}
 {1 :PaterJason/cmp-conjure
  :lazy true
  :config (lambda []
            (let [cmp (require :cmp)
                  config (cmp.get_config)]
              (table.insert config.sources {:name :conjure})
              (cmp.setup config)))}]
