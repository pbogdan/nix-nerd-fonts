let
  sources = import ./nix/sources.nix;
in
{ pkgs ? import sources.unstable { }
}:
let
  nix-nerd-fonts = import ./default.nix {
    inherit pkgs;
  };
in
pkgs.haskellPackages.shellFor {
  packages = _: [
    nix-nerd-fonts
  ];

  withHoogle = true;

  shellHook = ''
    export HIE_HOOGLE_DATABASE="$(dirname $NIX_GHC)/../share/doc/hoogle/default.hoo";
  '';
}
