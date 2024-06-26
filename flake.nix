{
  description = "norfetch - python fetch based off of norway";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      perSystem = {pkgs, config, ...}: {
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            python312
          ];
        };
        formatter = pkgs.alejandra;
        packages.norfetch = pkgs.callPackage ./wrapper.nix {};
        apps.default.norfetch = "${config.packages.norfetch}/bin/norfetch";
      };
      systems = [
        "x86_64-linux"
      ];
    };
}
