{ pkgs, ... }:
let 
  zoneName = "conjugate.lan";
  serial = 5;
  conjugateLocalZone = pkgs.writeText "zone.${zoneName}"
    ''
    $ORIGIN ${zoneName}.
    $TTL 300
    @                   IN    SOA     ns.${zoneName}. nick.conjugate.dev. (${toString serial} 3600 3600 36000000 3600)
    ${zoneName}.        IN    NS      ns
    ns                  IN    CNAME   nixdev

    nixdev              IN    A       10.89.1.250
    amdev               IN    A       10.89.1.254
    wintermute          IN    A       10.89.1.157
    '';
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

