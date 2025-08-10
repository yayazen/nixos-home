{ config, pkgs, ... }:
let
  zathura-bin = "${pkgs.zathura}/bin/zathura";

  convert-to-md = "${pkgs.writeShellScriptBin "print_html2md.sh" ''
    ${pkgs.python3Packages.html2text}/bin/html2text "$1" | ${pkgs.glow}/bin/glow -
  ''}/bin/print_html2md.sh";
in
{
  home.file.".config/mailcap" = {
    text = ''
      text/html; ${convert-to-md} '%s'; copiousoutput
      image/*; ${pkgs.kitty}/bin/kitty +kitten icat '%s'; needsterminal
      application/pdf; ${zathura-bin} '%s'; test=test -n "$DISPLAY"
      application/x-pdf; ${zathura-bin} '%s'; test=test -n "$DISPLAY"
    '';
  };
}
