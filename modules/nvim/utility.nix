{lib, ...}: {
  diffview-nvim.enable = false;

  # https://github.com/gbprod/yanky.nvim
  yanky-nvim.enable = false; # needs backend conf

  # https://github.com/kylechui/nvim-surround
  #surround.enable = true;

  # https://github.com/code-biscuits/nvim-biscuits
  nvim-biscuits.enable = true;

  motion = {
    hop.enable = false;
    leap.enable = false;
  };
  images = {
    image-nvim.enable = false;
    img-clip.enable = false;
  };
}
