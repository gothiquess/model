{
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkBefore mkDefault;
in {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
        intel-media-driver
        vpl-gpu-rt
      ];
    };
    keyboard.qmk.enable = true;
  };

  boot = {
    kernelParams = mkBefore [
      "i915.force_probe=5916"
      "logo.nologo"
      "fbcon=nodefer"
      "bgrt_disable"
      "vt.global_cursor_default=0"
      "quiet"
      "systemd.show_status=false"
      "rd.udev.log_level=3"
      "splash"
    ];

    consoleLogLevel = 3;

    loader = {
      systemd-boot.enable = mkDefault true;
      efi.canTouchEfiVariables = mkDefault true;
    };

    initrd = {
      enable = mkDefault true;
      verbose = mkDefault false;
      systemd.enable = mkDefault true;
      supportedFilesystems = ["btrfs"];

      systemd.services.rollback = {
        description = "Rollback BTRFS root subvolume to a pristine state";
        wantedBy = [
          "initrd.target"
        ];
        after = [
          "initrd-root-device.target"
        ];
        before = [
          "sysroot.mount"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          mkdir /btrfs_tmp
          mount /dev/root_vg/root /btrfs_tmp
          if [[ -e /btrfs_tmp/root ]]; then
              mkdir -p /btrfs_tmp/old_roots
              timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
              mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
          fi

          delete_subvolume_recursively() {
              IFS=$'\n'
              for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
                  delete_subvolume_recursively "/btrfs_tmp/$i"
              done
              btrfs subvolume delete "$1"
          }

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
              delete_subvolume_recursively "$i"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };
    };
  };

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      dates = "04:00";
      flake = "github:gothiquess/model";
      persistent = true;
      operation = "boot";

      # Schedule reboots between 3 AM and 5 AM.
      rebootWindow = {
        lower = "03:00";
        upper = "05:00";
      };
    };
  };

  documentation.nixos.enable = false;

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["flakes" "nix-command" "pipe-operators"];
      trusted-users = ["root" "@wheel"];
      substituters = [
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.nix-rice.overlays.default
      inputs.niri.overlays.niri
    ];
  };

  networking = {
    hostName = "circuitry";
    networkmanager = {
      enable = true;
      wifi.powersave = true;
    };
  };

  services = {
    openssh.enable = true;
    dbus.packages = [pkgs.dconf];
    udisks2.enable = true;
    pipewire = {
      enable = true;
      socketActivation = false;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    libinput.enable = true;

    # Allow uinput as non-root user (in @input group)
    udev.extraRules = ''
      KERNEL=="ttyACM0", MODE="0666"
      KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';
  };

  security = {
    sudo = {
      extraConfig = "Defaults lecture=never"; # avoid getting lectured on rollback
      wheelNeedsPassword = false;
    };
    polkit.enable = true;
  };

  systemd = {
    tmpfiles.rules = [
      "d /persist/home/ 1777 root -" # /persist/home created, owned by root.
      "d /persist/home/ess 0770 users -" # /persist/home/<user> created, owned by ess.
    ];
    user.services = {
      pipewire.wantedBy = ["default.target"];
      pipewire-pulse.wantedBy = ["default.target"];
    };
  };

  fileSystems."/persist".neededForBoot = true;

  environment = {
    systemPackages = with pkgs; [
      inputs.ghostty.packages.x86_64-linux.default
      file
      man-pages
      man-pages-posix
    ];
    persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/NetworkManager/system-connections" # networks info.
        "/etc/ssh" # host keys.
        "/var/lib/bluetooth" # bluetooth info.
        "/var/lib/nixos" # for users and groups IDs.
        "/var/lib/systemd/coredump" # systemd coredump.
        "/var/log" # logs.
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/var/keys/secret_file";
          parentDirectory = {mode = "u=rwx,g=,o=";};
        }
      ];
    };
  };

  programs = {
    command-not-found.enable = mkDefault false;
    dconf.enable = mkDefault true;
    fuse.userAllowOther = mkDefault true;
  };

  fonts = {
    packages = with pkgs; [
      manrope
      jetbrains-mono
      julia-mono
      unifont
      unifont_upper
      noto-fonts
      noto-fonts-emoji
      noto-fonts-monochrome-emoji
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      d2coding
    ];
    fontconfig = {
      enable = mkDefault true;
      defaultFonts = {
        monospace = [
          "JetBrains Mono NL Medium"
          "JuliaMono Medium"
        ];
        sansSerif = ["Manrope Medium"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  users = {
    mutableUsers = false;
    users."ess" = {
      isNormalUser = true;
      group = "users";
      hashedPasswordFile = "/persist/password/ess";
      extraGroups = ["wheel" "audio" "video" "input" "networkmanager"];
    };
  };

  xdg.portal = with pkgs; {
    enable = true;
    extraPortals = [xdg-desktop-portal-wlr];
    configPackages = [xdg-desktop-portal-wlr];
    config.common.default = [xdg-desktop-portal-wlr];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  time = {timeZone = "America/Bogota";};

  # Define the first version of NixOS installed for compatibility reasons.
  system.stateVersion = "24.11";
}
