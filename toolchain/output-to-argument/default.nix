{ pkgs }:
drv:
drv // (derivation (drv.drvAttrs // {
  builder = pkgs.runCommand "output-to-argument" {}
    "gcc -std=c99 -O3 ${./output-to-argument.c} -o $out";

  args = [ drv.drvAttrs.builder ] ++ (drv.drvAttrs.args or []);
}))
