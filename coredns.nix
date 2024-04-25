{ pkgs, dns, ... }:
let 
  zoneName = "conjugate.lan";

  conjugateLan = dns.lib.toString "conjugate.lan" (import zones/conjugatelan.nix { inherit dns; });

  conjugateLocalZone = pkgs.writeText "zone.${zoneName}" conjugateLan;
in {
  services.coredns = {
    enable = true;
    config = ''
      . {
        cache
        file ${conjugateLocalZone} ${zoneName}
        forward . /etc/resolv.conf
      }
    '';
  };
}

