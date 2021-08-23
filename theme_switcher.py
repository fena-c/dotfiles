import re

archivo_kitty = open("/home/fer/.config/kitty/colors.conf").read()

# {{{
claro_kitty = "#tema claro\nforeground #9c1111\nbackground #f5ecec\nforeground_bold #9c1111\ncursor #9c1111\n"
oscuro_kitty = "#tema oscuro\nforeground #c5c8c6\nbackground #2a1d1c\nforeground_bold #c5c8c6\ncursor #c5c8c6\n"
#archivo.write(claro)

claro_rofi = """/*tema claro*/


* {
  background: #f5ecec;
  border: #f5ecec;
  text: #9c1111;
  selecc: #d3b9b7;
}"""

oscuro_rofi = """/*tema oscuro*/


* {
  background: #2a1d1c;
  border: #2a1d1c;
  text: #f8e1e5;
  selecc: #3f2b2a;
}"""


# }}}

oscuro_vim = """
colorscheme gruvbox
set background=dark
let g:gruvbox_transparent_bg='0'
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
"""

claro_vim = """
colorscheme gruvbox
set background=light
let g:gruvbox_transparent_bg='0'
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
"""

claro_polybar = """[colors]
;background = ${xrdb:color0:#222}
;background = ${importado.colorsito}
background = #f5ecec
;background = #aaaaaa
background-alt = #2c1d32
;foreground = ${xrdb:color7:#222}
foreground = #a77370
foreground-alt = #a3be8c
primary = #5b7b81
secondary = #e60053
alert = #bf616a

"""

oscuro_polybar = """[colors]
;background = ${xrdb:color0:#222}
;background = ${importado.colorsito}
background = #2a1d1c
;background = #aaaaaa
background-alt = #2c1d32
;foreground = ${xrdb:color7:#222}
foreground = #a77370
foreground-alt = #a3be8c
primary = #5b7b81
secondary = #e60053
alert = #bf616a
"""


if len(re.findall("#tema claro", archivo_kitty)) == 1:
    archivo_kitty = open("/home/fer/.config/kitty/colors.conf", "w")
    print("abierto el archivo kitty")
    archivo_kitty.write(oscuro_kitty)
    print("kitty en modo oscuro")
    archivo_rofi=open("/home/fer/.config/rofi/colores.rasi", "w")
    print("abierto rofi")
    archivo_rofi.write(oscuro_rofi)
    print("rofi en modo oscuro")
    archivo_vim=open("/home/fer/.config/nvim/theme/theme.vim", "w")
    archivo_vim.write(oscuro_vim)
    archivo_polybar=open("/home/fer/.config/polybar/colors.ini", "w")
    archivo_polybar.write(oscuro_polybar)
else:
    archivo_kitty = open("/home/fer/.config/kitty/colors.conf", "w")
    print("abierto kitty")
    archivo_kitty.write(claro_kitty)
    print("kitty en modo claro")
    archivo_rofi=open("/home/fer/.config/rofi/colores.rasi", "w")
    print("abriendo rofi")
    archivo_rofi.write(claro_rofi)
    print("rofi en modo claro")
    archivo_vim=open("/home/fer/.config/nvim/theme/theme.vim", "w")
    archivo_vim.write(claro_vim)
    archivo_polybar=open("/home/fer/.config/polybar/colors.ini", "w")
    archivo_polybar.write(claro_polybar)

archivo_kitty.close()
archivo_rofi.close()
archivo_vim.close()
archivo_polybar.close()




#if len(re.findall("#tema claro", archivo)) == 1:
#    archivo.write(oscuro)
#else:
#    archivo.write(claro)
#




#tema claro
#foreground       #9c1111
#background #f5ecec
#foreground_bold   #9c1111                                                      
#cursor            #9c1111

#tema oscuro
#background       #2a1d1c                                                  
#foreground       #c5c8c6 
#foreground_bold  #c5c8c6                                                       
#cursor           #c5c8c6 

