{ pkgs, ... }:
{
  home.packages = with pkgs; [
    avrdude  # Atmel/Microchip microcontrollers
    dfu-util  # Bootloader util
    gcc-arm-embedded
  ];
}
