return {
    s({trig="trig", snippetType="autosnippet"}, {
        t("wow!")
    }),
    s({trig="mk", snippetType="autosnippet"}, {
        t("$"), i(0), t("$"),
    }),
    s({trig="zmod", snippetType="autosnippet"}, {
        t("\\mathbb{Z}/"), i(1), t("\\mathbb{Z} "), i(0)
    }),
    s({trig="root", snippetType="autosnippet"}, {
        t("\\sqrt["), i(1), t("]{"), i(2), t("} "), i(0)
    }),
    s({trig="func", snippetType="autosnippet"}, {
        i(1), t(" \\colon "), i(2), t(" \\rightarrow "), i(0)
    }),

    s({trig="(.*)rai",regTrig=true, snippetType="autosnippet"}, {
        f(function(args, snip) 
            return snip.captures[1].."^{"
        end),i(1), t("} "), i(0) 
    }),-- postfix???? está definido arriba, es cambiar el s del principio
    s({trig="(.*)subb",regTrig=true, snippetType="autosnippet"}, {
        f(function(args, snip) 
            return snip.captures[1].."_{"
        end),i(1), t("} "), i(0) 
    }),

    -- Transformar 3x2 en una matriz de 3 por 2
    s({trig="(.)x(.)",regTrig=true}, {
        t({"\\begin{pmatrix}", ""}), 
        d(1, function(args, snip)
            fila = tonumber(snip.captures[1])
            columna = tonumber(snip.captures[2])
            match = fila*columna
            template = {}
            pos = 1
            for x=1, fila do
                for y=1, columna do
                    table.insert(template, i(pos))
                    pos = pos + 1
                    table.insert(template, t(" & "))
                end
                table.remove(template)
                table.insert(template, t({" \\\\", ""}))
            end
            table.remove(template)
            return sn(nil, template)
        end),
        t({"", "\\end{pmatrix}"})
    }),


    s({trig="dm", snippetType="autosnippet"}, {
        t({"\\[", ""}), i(0), t({"", "\\]"}),  
    }),

    s({trig="beg", snippetType="autosnippet"}, {
        t("\\begin{"), i(1), t({"}", ""}), 
        i(0), 
        t({"", "\\end{"}), d(2, function(args) return sn(nil, {t(args[1])})end,{1}) , t("}") -- TODO 
    }),
    s({trig="geq", snippetType="autosnippet"}, {
        t("\\geq ") 
    }),
    s({trig="leq", snippetType="autosnippet"}, {
        t("\\leq ") 
    }),
    s({trig="::", snippetType="autosnippet"}, {
        t("\\colon ") 
    }),
    s({trig="...", snippetType="autosnippet"}, {
        t("\\dots ") 
    }),
    s({trig="00", snippetType="autosnippet"}, {
        t("\\infty ") 
    }),
    s({trig="inn", snippetType="autosnippet"}, {
        t("\\in ") 
    }),
    
    -- tab
    s({trig="sum"}, {
        t("\\sum_{"), i(1, "i=0"), t("}^{"), i(2, "n"),t("} "), i(0), 
    }),
    s({trig="int"}, {
        t("\\int{"), i(1, "a"), t("}^{"), i(2, "b"),t("} "), i(0), t(" dx") 
    }),

    s({trig="set"}, {
        t("\\{ "), i(1), t(" \\}"), i(0), 
    }),
    s({trig="cal"}, {
        t("\\mathcal{"), i(1), t("} "), i(0), 
    }),

    s({trig="lim"}, {
        t("\\lim\\limits_{"), i(1), t(" \\to "), i(2), t(" } "), i(0) 
    }),

    s({trig="it"}, {
        t("\\textit{"), i(1), t("} "), i(0), 
    }),

    s({trig="sec"}, {
        t("\\section{"), i(0), t("} ")
    }),

    s({trig="ssec"}, {
        t("\\subsection{"), i(0), t("} ")
    }),

    s({trig="mb"}, {
        t("\\mathbb{"), i(1), t("} "), i(0), 
    }),
    s({trig="gen"}, {
        t("\\langle "), i(1), t(" \\rangle "), i(0), 
    }),

    s({trig="pi"}, {
        t("\\langle "), i(1, "*"), t(" ,"), i(2, "*"), t(" \\rangle "), i(0), 
    }),

    s({trig="norm"}, {
        t("\\lVert "), i(1), t(" \\rVert "), i(0), 
    }),

    s({trig="lr"}, {
        t("\\left( "), i(1), t(" \\right) "), i(0), 
    }),
    
    s({trig="frac"}, {
        t("\\frac{"), i(1), t("}{"), i(2), t("} "), i(0) 
    }),
    
    s({trig="aligntex"}, {
        t({"\\begin{align*}", "\t\\iff&    &   "}), i(0), t({" &   &    &    \\\\", "\\end{align*}"}) 
        }),
}

