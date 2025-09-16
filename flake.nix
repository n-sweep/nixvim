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

          fzfNative = pkgs.nvimPlugins.telescope-fzf-native-nvim.overrideAttrs (oldAttrs: {
            buildInputs = oldAttrs.buildInputs or [] ++ [ pkgs.cmake pkgs.gnumake pkgs.clang ];
            postPatch = ''
              cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
              cmake --build build --config Release
              cmake --install build --prefix $out
            '';
          });

          postPatch = ''
            cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
            cmake --build build --config Release
            cmake --install build --prefix $out
          '';

          nixvimLib = nixvim.lib.${system};

          nixvim' = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = { inherit pkgs; };
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
            fzf = pkgs.fzf;
            fzfNative = pkgs.nvimPlugins.telescope-fzf-native-nvim;
          };

          buildInputs = [
            pkgs.cmake
            pkgs.clang
            pkgs.gnumake
          ];

          devShells = {
            default = pkgs.mkShell {
              buildInputs = [
                pkgs.fzf
                pkgs.cmake
                pkgs.clang
                pkgs.gnumake
              ];
            };
          };

        };
    };
}
