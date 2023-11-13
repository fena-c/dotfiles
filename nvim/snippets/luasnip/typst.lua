local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

return {
    s({trig="trig", snippetType="autosnippet"}, {
        t("wow!")
    }),
    s({trig="mk", snippetType="autosnippet"}, {
        t("$"), i(0), t("$"),
    }),
    s({trig="zmod", snippetType="autosnippet"}, {
        t("ZZ\\/"), i(1), t("ZZ "), i(0)
    }),
    s({trig="root", snippetType="autosnippet"}, {
        t("sqrt("), i(1), t(") "), i(0)
    }),
    s({trig="func"}, {
        i(1), t(" : "), i(2), t(" --> "), i(0)
    }),
    s({trig="mapeo"}, {
        i(1), t(" : "), i(2), t(" &--> "), i(3), t({"\\", ""}), i(4), t(" &arrow.r.long.bar "), i(0)
    }),

    s({trig="(.*)rai",regTrig=true, snippetType="autosnippet"}, {
        f(function(args, snip) 
            return snip.captures[1].."^("
        end),i(1), t(") "), i(0) 
    }),-- postfix???? está definido arriba, es cambiar el s del principio
    s({trig="(.*)subb",regTrig=true, snippetType="autosnippet"}, {
        f(function(args, snip) 
            return snip.captures[1].."_("
        end),i(1), t(") "), i(0) 
    }),

    -- Transformar 3x2 en una matriz de 3 por 2
    s({trig="(.)x(.)",regTrig=true}, {
        t({"mat(", ""}), 
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
                    table.insert(template, t(", "))
                end
                table.remove(template)
                table.insert(template, t({" ;", ""}))
            end
            table.remove(template)
            return sn(nil, template)
        end),
        t({"", ")"})
    }),


    s({trig="dm", snippetType="autosnippet"}, {
        t({"", "$ "}), i(0), t({" $"}),  
    }),

    s({trig="beg", snippetType="autosnippet"}, {
        t("#"), i(1), t({"[", ""}), 
        i(0), 
        t({"", "]"}) 
    }),
    s({trig="geq", snippetType="autosnippet"}, {
        t(">= ") 
    }),
    s({trig="leq", snippetType="autosnippet"}, {
        t("<= ") 
    }),
    s({trig="::", snippetType="autosnippet"}, {
        t(" colon ") 
    }),
    s({trig="00", snippetType="autosnippet"}, {
        t("oo ") 
    }),
    s({trig="inn", snippetType="autosnippet"}, {
        t("in ") 
    }),
    
    -- tab
    s({trig="sum"}, {
        t("sum_("), i(1, ""), t(")^("), i(2, ""),t(") "), i(0), 
    }),
    s({trig="int"}, {
        t("integral_("), i(1, "a"), t(")^("), i(2, "b"),t(") "), i(3), t(" dif ") , i(0, "x")
    }),

    s({trig="set"}, {
        t("{ "), i(1), t(" } "), i(0), 
    }),
    s({trig="cal"}, {
        t("cal("), i(1), t(") "), i(0), 
    }),

    s({trig="lim"}, {
        t("lim_("), i(1), t(" --> "), i(2), t(") "), i(0) 
    }),

    s({trig="it"}, {
        t("_"), i(1), t("_ "), i(0), 
    }),

    s({trig="mb"}, {
        t("bb("), i(1), t(") "), i(0), 
    }),

    s({trig="gen"}, {
        t("#pi["), i(1), t("] "), i(0), 
    }),

    s({trig="pi"}, {
        t("#pi["), i(1, "*"), t(" ,"), i(2, "*"), t("] "), i(0), 
    }),

    s({trig="norm"}, {
        t("| "), i(1), t(" | "), i(0), 
    }),

    s({trig="lr"}, {
        t("lr( "), i(1), t(" ) "), i(0), 
    }),

    
    s({trig="frac", snippetType="autosnippet"}, {
        t("("), i(1), t(")/("), i(2), t(") "), i(0) 
    }),
    
    s({trig="equiv"}, {
        t({"$", "&"}), i(1), t({"\\", "<==> &"}), i(0), t({"", "$"}) 
        }),

    s({trig="cadena"}, {
        t({"$", ""}), i(1), t(" &= "), i(2), t({"\\", "&= "}), i(0), t({"\\", "$"}) 
        }),
}
