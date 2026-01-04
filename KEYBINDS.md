# ⌨️ Bare Metal Neovim Keybindings

> Leader key: `<Space>`

---

## 🧭 Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate windows |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `<S-h>` | Previous buffer |
| `<S-l>` | Next buffer |
| `-` | Open parent directory (Oil) |
| `{` / `}` | Previous/Next symbol (Aerial) |
| `]]` / `[[` | Next/Prev reference (Illuminate) |
| `]t` / `[t` | Next/Prev TODO comment |
| `]c` / `[c` | Next/Prev git hunk |
| `]d` / `[d` | Next/Prev diagnostic |
| `]q` / `[q` | Next/Prev quickfix |

---

## 📁 File (leader + f)

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Git files |
| `<leader>fr` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Find hidden files |
| `<leader>fn` | New file |
| `<space>fb` | File browser |
| `<space>fB` | File browser (current dir) |

---

## 📝 Buffer (leader + b)

| Key | Action |
|-----|--------|
| `<leader>bd` | Delete buffer |
| `<leader>bn` | Next buffer |
| `<leader>bp` | Previous buffer |
| `<leader>ba` | Delete all but current |

---

## 🪟 Window (leader + w)

| Key | Action |
|-----|--------|
| `<leader>w` | Window commands (proxy to `<C-w>`) |
| `<C-Up/Down>` | Resize height |
| `<C-Left/Right>` | Resize width |

---

## 🔧 LSP (leader + l)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `gr` | References |
| `K` | Hover documentation |
| `<F2>` | Rename |
| `<F4>` | Code action |
| `<leader>ld` | Go to definition |
| `<leader>lr` | References |
| `<leader>lh` | Hover |
| `<leader>lf` | Format |
| `<leader>la` | Code action |
| `<leader>ln` | Rename |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>f` | Format buffer |
| `<leader>d` | Show diagnostic float |

---

## 🔍 Search (leader + s)

| Key | Action |
|-----|--------|
| `<leader>ss` | Search in buffer |
| `<leader>sw` | Search word under cursor |
| `<leader>sc` | Commands |
| `<leader>sk` | Keymaps |
| `<leader>sr` | Search & Replace (Spectre) |
| `<leader>st` | TODO comments |
| `<leader>sT` | TODO/FIX/FIXME only |

---

## 🌿 Git (leader + g)

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git log |
| `<leader>gg` | Lazygit |
| `ih` | Select hunk (visual/operator) |

---

## 🐛 Diagnostics (leader + x)

| Key | Action |
|-----|--------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xX` | Buffer diagnostics |
| `<leader>xq` | Quickfix list |
| `<leader>xl` | Location list |
| `<leader>xs` | Symbols |
| `<leader>xr` | LSP references |

---

## 💻 Terminal (leader + t)

| Key | Action |
|-----|--------|
| `<leader>tt` | Toggle terminal |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<Esc>` | Exit terminal mode |
| `<C-h/j/k/l>` | Navigate from terminal |

---

## 🔨 CMake (F-keys & Ctrl+m)

| Key | Action |
|-----|--------|
| `<F5>` | CMake Generate |
| `<F6>` | CMake Build |
| `<F7>` | CMake Run |
| `<F8>` | CMake Debug |
| `<F9>` | CMake Clean |
| `<C-m>g` | CMake Generate |
| `<C-m>b` | CMake Build |
| `<C-m>r` | CMake Run |
| `<C-m>c` | CMake Clean |
| `<C-m>s` | CMake Switch |
| `<C-m>o` | CMake Open |
| `<C-m>t` | Select target |

---

## 🐞 Debug (DAP)

| Key | Action |
|-----|--------|
| `<F5>` | Continue |
| `<F9>` | Toggle breakpoint |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>b` | Toggle breakpoint |

---

## 🔄 Refactoring (C/C++)

| Key | Action |
|-----|--------|
| `<F10>` (visual) | Extract function |
| `<F11>` (visual) | Extract variable |
| `<F12>` (visual) | Inline variable |
| `<C-r>f` | Extract block |
| `<C-r>i` | Inline function |
| `<C-r>p` | Debug printf |
| `<C-r>v` | Print variable |
| `<C-r>c` | Cleanup debug |

---

## 🔧 Clangd (C/C++)

| Key | Action |
|-----|--------|
| `<A-o>` | Switch header/source |
| `<A-i>` | Symbol info |
| `<A-t>` | Type hierarchy |
| `<A-m>` | Memory usage |
| `<A-a>` | AST |

---

## 📖 Documentation (Neogen)

| Key | Action |
|-----|--------|
| `<leader>ng` | Generate docs |
| `<leader>nf` | Function docs |
| `<leader>nc` | Class docs |
| `<leader>nt` | Type docs |

---

## 🎛️ Toggle (leader + t)

| Key | Action |
|-----|--------|
| `<leader>tn` | Toggle line numbers |
| `<leader>tr` | Toggle relative numbers |
| `<leader>tw` | Toggle word wrap / Twilight |
| `<leader>ts` | Toggle spell check |

---

## 📦 Session (leader + q)

| Key | Action |
|-----|--------|
| `<leader>qs` | Load session (current dir) |
| `<leader>qS` | Select session |
| `<leader>ql` | Load last session |
| `<leader>qd` | Stop recording |
| `<leader>qq` | Quit all |
| `<leader>qw` | Save and quit |
| `<leader>qf` | Force quit |
| `<C-s>` | Search sessions |

---

## 🧪 Testing (Neotest)

| Key | Action |
|-----|--------|
| `<leader>tt` | Run nearest test |
| `<leader>tf` | Run file tests |
| `<leader>ts` | Test summary |

---

## ✨ Misc

| Key | Action |
|-----|--------|
| `<leader>?` | Show all keymaps (which-key) |
| `<leader>e` | File explorer (Oil) |
| `<leader>a` | Aerial toggle (symbols) |
| `<leader>u` | Undotree toggle |
| `Q` | Disabled (no Ex mode) |

---

## 📋 Visual Mode

| Key | Action |
|-----|--------|
| `<A-j>` / `J` | Move selection down |
| `<A-k>` / `K` | Move selection up |
| `p` | Paste without yanking |

---

*Generated for Bare Metal Neovim Config*
