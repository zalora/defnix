{ output-to-argument
, pkgs }:

let
  cc = "${pkgs.gcc}/bin/gcc";
  inherit (pkgs) coreutils system;
in

c: let
  base = c.name or baseNameOf (toString c);
in output-to-argument (derivation {
  name = builtins.substring 0 (builtins.stringLength base - 2) base;

  inherit system;

  builder = cc;

  # GCC wrapper uses cat...
  PATH = [ "${coreutils}/bin" ];

  args = [ c "-O3" "-o" "@out" ];
})
