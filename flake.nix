{
  description = "my project description";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            pnpm
            http-server
          ];
        };
      });
}
