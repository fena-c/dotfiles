

# opcion = true
# opcion = false

function cambiar_barras(opcion)
    archivo = open("/home/fer/.config/awesome/core/rules.lua") do io
        readlines(io)
    end
    pos = findall(line -> startswith(line, "      }, properties = { titlebars_enabled ="), archivo)[1]
    replace!(archivo, archivo[pos]=>"      }, properties = { titlebars_enabled = $opcion }")
    write("/home/fer/.config/awesome/core/rules.lua", reduce(*, archivo.*"\n"))
end


cambiar_barras(ARGS[1])




