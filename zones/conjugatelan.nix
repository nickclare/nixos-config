{ dns }:
with dns.lib.combinators;
{
  SOA = {
    nameServer = "ns";
    adminEmail = "nick@conjugate.dev";
    serial = 5;
  };

  NS = [ "ns" ];

  subdomains = {
    ns = { CNAME = ["nixdev"]; };


    nixdev =  host "10.89.1.250" null;
    amdev = host "10.89.1.254" null;
    wintermute = host "10.89.1.157" null;
  };
  }
