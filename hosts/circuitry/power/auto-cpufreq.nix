{lib, ...}: let
  inherit (lib.modules) mkDefault;
  MHz = x: x * 1000;
in {
  services.auto-cpufreq = {
    enable = true;

    settings = {
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        scaling_min_freq = mkDefault (MHz 1200);
        scaling_max_freq = mkDefault (MHz 1800);
        turbo = "never";

        # this enables charging thresholds, this means that the battery will only
        # charge when it's above the start_threshold and stop charging when it's
        # below the stop_threshold
        enable_thresholds = true;
        start_threshold = 20;
        stop_threshold = 80;
      };

      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        scaling_min_freq = mkDefault (MHz 1800);
        scaling_max_freq = mkDefault (MHz 3100);
        turbo = "auto";
      };
    };
  };
}
