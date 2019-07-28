{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
  buildInputs = [
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-test
    # ./default.nix was created with node2nix ./node-packages.json
    # All works well Nix-wise, except that create-elm-app
    # bundles its own elm binary, and expects to install it imperatively
    # with binrwrap-install (which is not in the environment)
    (import ./default.nix { inherit pkgs; }).create-elm-app
  ];
}
