{
  description = "IP address arithmetic and validation in Nix";

  inputs = {
    lib-net = {
      url = "https://gist.github.com/duairc/5c9bb3c922e5d501a1edb9e7b3b845ba/archive/3885f7cd9ed0a746a9d675da6f265d41e9fd6704.tar.gz";
      flake = false;
    };
  };

  outputs = inputs: {
    overlays = rec {
      default =
        (final: prev: {
          lib = prev.recursiveUpdate prev (raw final.lib prev.lib);
        });
      raw =
        (final: prev:
          (import ./nix/net-extensions.nix {
            lib = prev;
            libNet = (import "${inputs.lib-net.outPath}/net.nix" { lib = prev; }).lib.net;
          }));
    };
  };
}
