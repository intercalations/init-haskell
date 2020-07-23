let
  sources = import ./nix/sources.nix;
  compilerVersion = "ghc883";
  ghcide = (import sources.ghcide-nix {})."ghcide-${compilerVersion}";
  hnix = import sources.iohk-hnix {};
  pkgs = (import hnix.sources.nixpkgs) hnix.nixpkgsArgs;
in
(import ./.).shellFor {
  withHoogle = true;
  buildInputs = [
    ghcide
    (pkgs.haskell-nix.tool compilerVersion "hpack" { index-state = "{{snapshot}}"; version = "0.34.2"; })
    (pkgs.haskell-nix.tool compilerVersion "ghcid" { index-state = "{{snapshot}}"; version = "0.8.7"; })
  ];
}
