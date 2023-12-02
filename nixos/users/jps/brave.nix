{ pkgs, ... }:
{
  programs.brave = {
    enable = true;
		package = pkgs.brave.override {
        # https://peter.sh/experiments/chromium-command-line-switches/
        commandLineArgs = ''
        --load-media-router-component-extension=1
        --enable-smooth-scrolling
        '';
      };
	};
}
