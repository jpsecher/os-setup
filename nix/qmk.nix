{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dfu-programmer  # Needed for QMK with ATMega32u chips/keyboards
    qmk  # Keyboard firmware
  ];
}
