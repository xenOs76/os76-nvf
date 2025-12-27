[
  {
    key = "<leader>m";
    mode = "n";
    silent = true;
    action = ":make<CR>";
  }
  {
    key = "<leader>l";
    mode = ["n" "x"];
    silent = true;
    action = "<cmd>cnext<CR>";
  }

  {
    key = "<leader>nb";
    mode = ["n"];
    silent = true;
    action = "<cmd>Navbuddy<CR>";
    desc = "[N]av[B]uddy";
  }

  {
    key = "<leader>qq";
    mode = "n";
    action = "<cmd>qa<CR>";
    silent = true;
    noremap = true;
    desc = "Quit All";
  }
  {
    key = "<leader>ww";
    mode = "n";
    action = "<cmd>write<CR>";
    silent = true;
    noremap = true;
    desc = "[w]rite";
  }

  {
    key = "<leader>ee";
    mode = "n";
    action = "<cmd>Neotree dir=./ toggle<CR>";
    silent = true;
    noremap = true;
    desc = "Explorer NeoTree (cwd)";
  }
  {
    key = "<leader>eb";
    mode = "n";
    action = "<cmd>Neotree buffers toggle<CR>";
    silent = true;
    noremap = true;
    desc = "NeoTree Buffer Explorer";
  }
  {
    key = "<leader>eE";
    mode = "n";
    action = "<cmd>Neotree dir=/ toggle<CR>";
    silent = true;
    noremap = true;
    desc = "Explorer NeoTree (Root Dir)";
  }

  {
    key = "<leader>eh";
    mode = "n";
    action = "<cmd>Neotree dir=/home/xeno toggle<CR>";
    silent = true;
    noremap = true;
    desc = "Explorer NeoTree (Home Dir)";
  }

  {
    key = "<leader>fg";
    mode = "n";
    action = "<cmd>FzfLua grep<CR>";
    silent = true;
    noremap = true;
    desc = "FzfLua grep";
  }
  {
    key = "<leader>fv";
    mode = "n";
    action = "<cmd>FzfLua grep_visual<CR>";
    silent = true;
    noremap = true;
  }
  {
    key = "<leader>fw";
    mode = "n";
    action = "<cmd>FzfLua grep_cword<CR>";
    silent = true;
    noremap = true;
    desc = "FzfLua grep_cword";
  }
  {
    key = "<leader>fr";
    mode = "n";
    action = "<cmd>FzfLua resume<CR>";
    silent = true;
    noremap = true;
    desc = "FzfLua resume";
  }
  {
    key = "<leader>ff";
    mode = "n";
    action = "<cmd>Fzf files<CR>";
    silent = true;
    noremap = true;
    desc = "FzfLua files";
  }
  {
    key = "<leader>fb";
    mode = "n";
    action = "<cmd>Fzf buffers<CR>";
    silent = true;
    noremap = true;
    desc = "FzfLua buffers";
  }
  {
    key = "<leader>gs";
    mode = "n";
    action = "<cmd>Git<CR>";
    silent = true;
    noremap = true;
    desc = "[g]it [s]tatus";
  }
  {
    key = "<leader>gb";
    mode = "n";
    action = "<cmd>Gitsigns blame<CR>";
    silent = true;
    noremap = true;
    desc = "Gitsigns blame";
  }
  {
    key = "<leader>gl";
    mode = "n";
    action = "<cmd>LazyGit<CR>";
    silent = true;
    noremap = true;
    desc = "LazyGit";
  }
  {
    key = "<leader>tt";
    mode = "n";
    action = "<cmd>ToggleTerm<CR>";
    silent = true;
    noremap = true;
    desc = "ToggleTerm";
  }
  {
    key = "<leader>y";
    mode = [
      "n"
      "v"
    ];
    action = ''"+y'';
    silent = true;
    noremap = true;
    desc = "[y]ank to system clipboard";
  }
  {
    key = "<leader>Y";
    mode = "n";
    action = ''"+Y'';
    silent = true;
    noremap = true;
    desc = "[Y]ank line to system clipboard";
  }
  {
    key = "<leader>he";
    mode = ["n" "v"];
    action = ":lua vim.lsp.inlay_hint.enable(true)<CR>";
    silent = true;
    noremap = true;
    desc = "Inlay [h]ints [e]nable";
  }

  {
    key = "<leader>hd";
    mode = ["n" "v"];
    action = ":lua vim.lsp.inlay_hint.enable(false)<CR>";
    silent = true;
    noremap = true;
    desc = "Inlay [h]ints [d]isable";
  }

  {
    key = "Q";
    mode = "n";
    action = "<nop>";
    silent = true;
    noremap = true;
    desc = "Don't";
  }
]
