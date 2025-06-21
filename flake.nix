{
    inputs = {
        nixpkgs.url     = "nixpkgs/nixpkgs-unstable";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, nixpkgs, flake-utils }:
        flake-utils.lib.eachDefaultSystem(system:
            let pkgs = import nixpkgs { inherit system; }; in {
                packages.default = pkgs.rustPlatform.buildRustPackage {
                    pname = "raytracer";
                    version = "0.0.1";

                    src = ./.;
                    cargoLock.lockFile = ./Cargo.lock;
                };
                devShells.default = pkgs.mkShell {
                    nativeBuildInputs = with pkgs; [ cargo rustc ];
                };
            }
        );
}
