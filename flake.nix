{
    description = "My NixOs config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

            # THIS IS IMPORTANT
            # Mismatched system dependencies will lead to crashes and other issues.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, quickshell }@inputs: {
        nixosConfigurations = {
            swordfish = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./common.nix
                    ./hosts/swordfish/configuration.nix
                ];
            };
            bebop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./common.nix
                    ./hosts/bebop/configuration.nix
                ];
            };
        };
    };
}
