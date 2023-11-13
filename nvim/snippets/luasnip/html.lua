return {
    s({trig="tag"}, {
        t("<"), i(1), t("> "), 
        i(0), 
        t(" <"), recuperar(2,1) , t("/>") -- TODO 
    }),
    s({trig="tagi"}, {
        t("<"), i(1), t({"> ", "\t"}), 
        i(0), 
        t({"","<"}), recuperar(2,1) , t("/>") -- TODO 
    }),
    s({trig="link"}, {
        t("<a href=\""), i(1), t("\"> "), 
        i(0), 
        t(" </a>") -- TODO 
    }),
    s({trig="img"}, {
        t("<img src=\""), i(0), t("\">")
    }),
}
