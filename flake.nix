{
  description = "Go application dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        go = pkgs.go_1_26;
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "app";
          version = "0.0.1";
          src = ./.;
          vendorHash = null; # uses vendor / directory
          inherit go;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            go
            pkgs.ponysay
          ];

          shellHook = ''
            echo "Go $(go version)"
          '';
        };
      }
    );
}
