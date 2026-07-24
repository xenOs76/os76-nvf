{
  description = "NVF-based Neovim with minimal + IDE profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    flake-utils.url = "github:numtide/flake-utils";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nvf = {
      #url = "github:NotAShelf/nvf/v0.8";
      url = "github:NotAShelf/nvf/07d5eb208b8f16306b10342b634da7e07e926fa5"; # 2026-07-24
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gitlineage-nvim = {
      # url = "github:LionyxML/gitlineage.nvim";
      url = "github:zenangst/gitlineage.nvim?ref=fix/file-not-tracked-by-git";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://nvf.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
    ];
  };

  outputs = {
    # self,
    nixpkgs,
    flake-utils,
    # home-manager,
    nvf,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        gitlineage-repo = inputs.gitlineage-nvim;

        os76NvfCfg = {
          terraformAutoformat = true;
          yamlAutoformat = true;
        };

        nvimMinimal = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./modules/nvim/default.nix
            ./modules/nvim/minimal/default.nix
          ];
          extraSpecialArgs = {
            inherit gitlineage-repo;
          };
        };

        nvimIDE = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./modules/nvim/default.nix
            {inherit os76NvfCfg;}
            ./modules/nvim/ide/default.nix
          ];
          extraSpecialArgs = {
            inherit gitlineage-repo;
          };
        };
      in {
        exportedInputs = inputs;

        packages = {
          nvim-minimal = nvimMinimal;
          nvim-ide = nvimIDE;
          default = nvimMinimal;
        };

        apps = {
          nvim-minimal = {
            type = "app";
            program = "${nvimMinimal.neovim}/bin/nvim";
          };

          nvim-ide = {
            type = "app";
            program = "${nvimIDE.neovim}/bin/nvim";
          };

          default = {
            type = "app";
            program = "${nvimMinimal.neovim}/bin/nvim";
          };
        };
      }
    );
}
