{
  description = "NVF-based Neovim with minimal + IDE profiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf/v0.8";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nvf,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};

        nvimMinimal = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./modules/nvim/default.nix
            ./modules/nvim/minimal/default.nix
          ];
        };

        nvimIDE = nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [
            ./modules/nvim/default.nix
            ./modules/nvim/ide/default.nix
          ];
        };
      in {
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
