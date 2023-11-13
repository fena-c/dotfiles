
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Para que haga splits automáticamente
function WinMove(key)
    local curwin = vim.fn.winnr()
    vim.cmd(string.format("wincmd %s", key))
    local vert = {}
    vert["k"] = 1
    vert["j"] = 1
    if curwin == vim.fn.winnr() then
        if vert[key]~= nil then
            vim.cmd("wincmd s")
        else
            vim.cmd("wincmd v")
        end
        vim.cmd(string.format("wincmd %s", key))
    end
end



keymap("", ",", "<Nop>", opts) -- este es para el leader key
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", ":lua WinMove('h')<CR>", opts)
keymap("n", "<C-j>", ":lua WinMove('j')<CR>", opts)
keymap("n", "<C-k>", ":lua WinMove('k')<CR>", opts)
keymap("n", "<C-l>", ":lua WinMove('l')<CR>", opts)

keymap("n", "<leader>ne", ":NvimTreeToggle<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("t", "<esc>", "<C-\\><C-n>:ToggleTerm<CR>", term_opts)

keymap("n", "<A-1>", "1gt", opts)
keymap("n", "<A-2>", "2gt", opts)
keymap("n", "<A-3>", "3gt", opts)
keymap("n", "<A-4>", "4gt", opts)
keymap("n", "<A-5>", "5gt", opts)
keymap("n", "<A-6>", "6gt", opts)
keymap("n", "<leader>tc",":tabclose<CR>", opts)
keymap("n", "<leader>tn",":tabnew<CR>", opts)


keymap("v", "<C-p>", ":ToggleTermSendVisualSelection <T_ID><CR>", opts)



-- para los folds
keymap("n", "<space>","za", opts)
