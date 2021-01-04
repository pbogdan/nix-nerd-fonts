let
  sources = import ./nix/sources.nix;
in
{ pkgs ? import sources.unstable { }
, profiling ? false
}:
let
  hspkgs = pkgs.haskellPackages.override {
    overrides = hself: hsuper: with pkgs.haskell.lib; {
      ede = dontCheck
        (unmarkBroken (
          overrideCabal hsuper.ede (
            drv: {
              postPatch = drv.postPatch or "" + ''
                sed -i 91,104d ede.cabal
              '';
            }
          )
        ));


      shell-cmd = import sources.shell-cmd {
        inherit pkgs;
      };
    };
  };

  inherit (hspkgs)
    callCabal2nix
    ;

  inherit (pkgs.haskell.lib)
    enableLibraryProfiling
    enableExecutableProfiling
    justStaticExecutables
    ;

  inherit (pkgs)
    lib
    nix-gitignore
    ;

  extra-source-excludes = [
    "/.envrc"
    "/shell.nix"
  ];
  nix-nerd-fonts = callCabal2nix
    "nix-nerd-fonts"
    (nix-gitignore.gitignoreSource extra-source-excludes ./.)
    { };
in
if profiling then
  enableExecutableProfiling (enableLibraryProfiling nix-nerd-fonts)
else
  justStaticExecutables nix-nerd-fonts
