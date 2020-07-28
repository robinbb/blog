{ nixpkgs ? import <nixpkgs>
}:
let
  pkgs = nixpkgs {};
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    gnugrep
    hugo
  ];
}
