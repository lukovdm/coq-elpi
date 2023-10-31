{
  description = "ElPi test";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell
          {
            nativeBuildInputs = with pkgs; [ gnumake gmp opam python310Packages.pygments ];
          };
        shellHook = ''
          eval $(opam env --switch=elpi-dev)
        '';
      });
}
