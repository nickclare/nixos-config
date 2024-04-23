{ pkgs, ... }:
{
  users.users.developer = {
    isNormalUser = true;
    home = "/home/developer";
    extraGroups = [ "wheel" ];
  };
}
