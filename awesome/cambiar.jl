cd("/home/fer/.config/awesome/theme")


los_temas = Dict(
    "default" => "dark",
    "light" => "light",
    "purple" => "dark"
)

para_alacritty = Dict(
    "default" => "mocha",
    "light" => "green_light",
    "purple" => "purple"
)

le_tema = ARGS[1]
tipo_tema = los_temas[ARGS[1]]




#Definir cada función para cada situación

function alacritty(el_tema)
    alacritty = open("/home/fer/.config/alacritty/alacritty.yml") do io
        readlines(io)
    end
    color_alacritty = "colors: *$(el_tema)" 
    pop!(alacritty)
    push!(alacritty, color_alacritty)
    write("/home/fer/.config/alacritty/alacritty.yml", reduce(*, alacritty.*"\n"))
end


function neovim(el_tema)
    theme = el_tema == "light" ? "latte" : "mocha"
    archivo = open("/home/fer/.config/nvim/init.lua") do io
        readlines(io)
    end
    pos = findall(line -> startswith(line, "vim.g.catppuccin"), archivo)[1]
    replace!(archivo, archivo[pos]=>"vim.g.catppuccin_flavour = \"$theme\"")
    write("/home/fer/.config/nvim/init.lua", reduce(*, archivo.*"\n"))
end

# esto tengo que encontrar y cambiar 
# local tema = "default"

function awesome(el_tema)
    @show el_tema
    archivo = open("/home/fer/.config/awesome/theme/init.lua") do io
        readlines(io)
    end
    @show archivo
    pos = findall(line -> startswith(line, "local tema"), archivo)[1]
    @show pos
    replace!(archivo, archivo[pos] => "local tema = \"$el_tema\" ")
    @show archivo
    write("/home/fer/.config/awesome/theme/init.lua", reduce(*, archivo.*"\n"))
end

#Ejecutar todo
awesome(le_tema)
alacritty(para_alacritty[ARGS[1]])
neovim(tipo_tema)













