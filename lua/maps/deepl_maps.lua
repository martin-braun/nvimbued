local M = {}

M.keys = {

    {
        "<leader>tren", '<CMD>call deepl#v("EN")<CR>',
        mode = 'v', desc = "Translate to English", remap = true
    },
    {
        "<leader>trde", '<CMD>call deepl#v("DE")<CR>',
        mode = 'v', desc = "Translate to German", remap = true
    },
    {
        "<leader>trfr", '<CMD>call deepl#v("FR")<CR>',
        mode = 'v', desc = "Translate to French", remap = true
    },
    {
        "<leader>tres", '<CMD>call deepl#v("ES")<CR>',
        mode = 'v', desc = "Translate to Spanish", remap = true
    },
    {
        "<leader>trpt", '<CMD>call deepl#v("PT")<CR>',
        mode = 'v', desc = "Translate to Portuguese", remap = true
    },
    {
        "<leader>trit", '<CMD>call deepl#v("IT")<CR>',
        mode = 'v', desc = "Translate to Italian", remap = true
    },
    {
        "<leader>trnl", '<CMD>call deepl#v("NL")<CR>',
        mode = 'v', desc = "Translate to Dutch", remap = true
    },
    {
        "<leader>trfi", '<CMD>call deepl#v("FI")<CR>',
        mode = 'v', desc = "Translate to Finnish", remap = true
    },
    {
        "<leader>trda", '<CMD>call deepl#v("DA")<CR>',
        mode = 'v', desc = "Translate to Danish", remap = true
    },
    {
        "<leader>trnb", '<CMD>call deepl#v("NB")<CR>',
        mode = 'v', desc = "Translate to Norwegian", remap = true
    },
    {
        "<leader>trhu", '<CMD>call deepl#v("HU")<CR>',
        mode = 'v', desc = "Translate to Hungarian", remap = true
    },
    {
        "<leader>trtr", '<CMD>call deepl#v("TR")<CR>',
        mode = 'v', desc = "Translate to Turkish", remap = true
    },
    {
        "<leader>trpl", '<CMD>call deepl#v("PL")<CR>',
        mode = 'v', desc = "Translate to Polish", remap = true
    },
    {
        "<leader>trca", '<CMD>call deepl#v("CA")<CR>',
        mode = 'v', desc = "Translate to Catalan", remap = true
    },
    {
        "<leader>trsv", '<CMD>call deepl#v("SV")<CR>',
        mode = 'v', desc = "Translate to Swedish", remap = true
    },
    {
        "<leader>trzh", '<CMD>call deepl#v("ZH")<CR>',
        mode = 'v', desc = "Translate to Chinese", remap = true
    },
    {
        "<leader>trcs", '<CMD>call deepl#v("CS")<CR>',
        mode = 'v', desc = "Translate to Czech", remap = true
    },
    {
        "<leader>trro", '<CMD>call deepl#v("RO")<CR>',
        mode = 'v', desc = "Translate to Romanian", remap = true
    },
    {
        "<leader>trbg", '<CMD>call deepl#v("BG")<CR>',
        mode = 'v', desc = "Translate to Bulgarian", remap = true
    },
    {
        "<leader>trko", '<CMD>call deepl#v("KO")<CR>',
        mode = 'v', desc = "Translate to Korean", remap = true
    },
    {
        "<leader>trja", '<CMD>call deepl#v("JA")<CR>',
        mode = 'v', desc = "Translate to Japanese", remap = true
    },

}

return M

