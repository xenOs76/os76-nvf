{
  description = "NVF-based Neovim with minimal + IDE profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-utils.url = "github:numtide/flake-utils";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nvf = {
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-terraform.url = "github:stackbuilders/nixpkgs-terraform";

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
      "https://nixpkgs-terraform.cachix.org"
      "https://nvf.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw="
      "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
    ];
  };

  outputs = {
    # self,
    nixpkgs,
    flake-utils,
    # home-manager,
    nixpkgs-terraform,
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
          # https://github.com/stackbuilders/nixpkgs-terraform/blob/main/versions.json
          terraformVersion = "1.14";
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
            inherit nixpkgs-terraform;
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
