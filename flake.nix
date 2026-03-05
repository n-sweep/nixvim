{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        let
          pkgs' = pkgs.extend (final: prev: {

            # disable obsidian dependency check; always fails on _fzf
            vimPlugins = prev.vimPlugins.extend (vfinal: vprev: {

              obsidian-nvim = vprev.obsidian-nvim.overrideAttrs (old: {
                doCheck = false;
                src = pkgs.fetchFromGitHub {
                  owner = "obsidian-nvim";
                  repo = "obsidian.nvim";
                  rev = "main";
                  hash = "sha256-Xl5Bq8yyZ/9Wlm/ydHXrkCRJzdoIp/vdyXZ9nZjvopY=";
                };
              });

              nvim-treesitter = vprev.nvim-treesitter.overrideAttrs (old: {
                src = pkgs.fetchFromGitHub {
                  owner = "nvim-treesitter";
                  repo = "nvim-treesitter";
                  rev = "42fc28ba918343ebfd5565147a42a26580579482";
                  hash = "sha256-CVs9FTdg3oKtRjz2YqwkMr0W5qYLGfVyxyhE3qnGYbI=";
                };
              });

              otter-nvim = vprev.otter-nvim.overrideAttrs (old: {
                doCheck = false;
                src = pkgs.fetchFromGitHub {
                  owner = "jmbuhr";
                  repo = "otter.nvim";
                  rev = "main";
                  hash = "sha256-L4MMWXyAZGrdhKiiTQz93nOMSAUnO8k+UQUOSl4GJ4s=";
                };
              });

            });

          });
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            pkgs = pkgs';
            module = import ./config;
            extraSpecialArgs = { pkgs = pkgs'; };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
          };
        };
    };
}
