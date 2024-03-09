{
  programs.chromium = {
    enable = true;
    # https://peter.sh/experiments/chromium-command-line-switches/
    commandLineArgs = [
      "--load-media-router-component-extension=1"
      "--enable-media-router"
      "--enable-smooth-scrolling"
      "--force-dark-mode"
    ];
  };
}
