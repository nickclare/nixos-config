{ pkgs, ... }:

{
  services.tailscale.enable = true;

  # authenticate with tailscale
  systemd.services.tailscale-autoconnect = {
    description = "Connect to tailscale network";

    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
      # wait for tailscale daemon to start
      sleep 2

      # check if we are already authenticated to our tailnet
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then
        exit 0
      fi

      # otherwise authenticate using token
      ${tailscale}/bin/tailscale up -authkey $(${coreutils}/bin/cat /run/secrets/tailscale_token)
    '';
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "yes"; #TODO: remove this at a later stage

  networking.firewall.enable = false;

}
