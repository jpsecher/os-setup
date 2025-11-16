{ pkgs, ... }:
{
  home.packages = with pkgs; [
    avrdude  # Atmel/Microchip microcontrollers
    dfu-util  # Bootloader
    gcc-arm-embedded
  ];
}
