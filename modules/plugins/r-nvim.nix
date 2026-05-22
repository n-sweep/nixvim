{ inputs, ... }:
{
  config.flake.modules.nixvim.r-nvim = { pkgs, ... }:
  let
    base = inputs.r-nvim.packages.${pkgs.system}.default;

    nvimcom = pkgs.stdenv.mkDerivation {
      name = "r-nvimcom";
      src = "${base}/nvimcom";
      nativeBuildInputs = [ pkgs.R pkgs.gcc pkgs.gnumake ];
      buildPhase = "R CMD build .";
      installPhase = ''
        mkdir -p $out
        R CMD INSTALL --library=$out nvimcom_*.tar.gz
      '';
    };

    r-nvim = pkgs.runCommand "vimplugin-r.nvim" {
      nativeBuildInputs = [ pkgs.gcc pkgs.gnumake ];
    } ''
      cp -r ${base} $out
      chmod -R +w $out
      make -C $out/rnvimserver
    '';
  in
  {
    extraPlugins = [ r-nvim ];
    extraFiles = { "plugin/r-nvim.lua".source = ./_lua/r-nvim.lua; };
    extraConfigLuaPre = ''vim.env.R_LIBS_USER = "${nvimcom}"
        .. (vim.env.R_LIBS_USER ~= nil and vim.env.R_LIBS_USER ~= ""
            and ":" .. vim.env.R_LIBS_USER or "")'';
  };
}
