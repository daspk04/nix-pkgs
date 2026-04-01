# tensorflow github source hashes
version:
let
  hashes = {
    "2.18.0" = {
      gitHash = "sha256-/S//LZwWGJPoqoGalSntrPhd6NuGTl1VVmQm17bIwSs=";
    };
    "2.19.0" = {
      gitHash = "sha256-61Ceoed8D65IvipM0OsXJ3xGWi5jtUDPUxhYNOffImU=";
    };
    "2.20.0" = {
      gitHash = "sha256-nGWQ+T5FmL+hZucbjQlCRTJM1i//gSzua1QxcBFeqwM=";
    };
  };
in
builtins.getAttr version hashes
