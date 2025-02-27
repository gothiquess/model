{
  inputs,
  pkgs,
  theme,
  ...
}: let
  inherit (inputs.niri.lib.kdl) node plain leaf flag;
  wallpapers-path = ../../../../../theme/wallpaper.png;
in
  with theme.colors; {
    programs.niri.enable = true;
    programs.niri.package = pkgs.niri-unstable;
    programs.niri.config = [
      (plain "input" [
        (plain "keyboard" [
          (plain "xkb" [
            (leaf "layout" "us")
            # Switch to another layout with SUPER + SPC
            # RIGHT-ALT as compose key,
            # Swap CAPS with ESC
            (leaf "options" "grp:win_space_toggle,compose:ralt,caps:escape,misc:apl")
          ])

          (leaf "repeat-delay" 600)
          (leaf "repeat-rate" 25)
        ])

        (plain "touchpad" [
          (flag "tap")
          (flag "natural-scroll")
          (leaf "accel-speed" 0.2)
          (leaf "accel-profile" "flat")
          (leaf "scroll-method" "two-finger")
        ])

        (plain "mouse" [
          (flag "natural-scroll")
          (leaf "accel-speed" 0.2)
          (leaf "accel-profile" "flat")
        ])

        (plain "trackpoint" [
          # (flag "off")
        ])

        (plain "tablet" [
          (leaf "map-to-output" "eDP-1")
        ])

        (plain "touch" [
          (leaf "map-to-output" "eDP-1")
        ])
      ])

      (node "output" "eDP-1" [
        (leaf "transform" "normal")
        (leaf "mode" "1366x768@60")
      ])

      (plain "layout" [
        (plain "focus-ring" [
          (leaf "width" 2)
          (leaf "active-color" "${primary.focused}")
          (leaf "inactive-color" "${primary.inactive}")
        ])

        # You can also add a border. It's similar to the focus ring, but always visible.
        (plain "border" [
          (leaf "width" 2)
          (leaf "active-color" "${primary.focused}")
          (leaf "inactive-color" "${primary.focused}")
        ])

        # TODO:
        # (plain "tab-indicator" [
        #   (leaf "hide-when-single-tab" true)
        #   (leaf "place-within-column" true)
        #   (leaf "gap" 5)
        #   (leaf "width" 4)
        #   (leaf "length" "total-proportion=1.0")
        #   (leaf "position" "right")
        #   (leaf "gaps-between-tabs" 2)
        #   (leaf "corner-radius" 8)
        #   (leaf "active-color" "${primary.focused}")
        #   (leaf "inactive-color" "${primary.match}")
        # ])

        # You can customize the widths that "switch-preset-column-width" (Mod+R) toggles between.
        (plain "preset-column-widths" [
          (leaf "proportion" (1.0 / 3.0))
          (leaf "proportion" (1.0 / 2.0))
          (leaf "proportion" (2.0 / 3.0))
        ])

        # You can change the default width of the new windows.
        (plain "default-column-width" [
          (leaf "proportion" 0.5)
        ])
        (leaf "gaps" 4)

        # Struts shrink the area occupied by windows, similarly to layer-shell panels.
        # You can think of them as a kind of outer gaps. They are set in logical pixels.
        # Left and right struts will cause the next window to the side to always be visible.
        # Top and bottom struts will simply add outer gaps in addition to the area occupied by
        # layer-shell panels and regular gaps.
        (plain "struts" [
          # (leaf "left" 64)
          # (leaf "right" 64)
          # (leaf "top" 64)
          # (leaf "bottom" 64)
        ])

        # When to center a column when changing focus, options are:
        # - "never", default behavior, focusing an off-screen column will keep at the left
        #   or right edge of the screen.
        # - "on-overflow", focusing a column will center it if it doesn't fit
        #   together with the previously focused column.
        # - "always", the focused column will always be centered.
        (leaf "center-focused-column" "never")
      ])

      # Add lines like this to spawn processes at startup.
      # Note that running niri as a session supports xdg-desktop-autostart,
      # which may be more convenient to use.
      (leaf "spawn-at-startup" "xwayland-satellite")
      (leaf "spawn-at-startup" ["swaybg" "-m" "fill" "-i" "${wallpapers-path}"])
      (leaf "spawn-at-startup" "plover")

      # You can override environment variables for processes spawned by niri.
      (plain "environment" [
        (leaf "BROWSER" "firefox")
        (leaf "EDITOR" "emacs")
        (leaf "DISPLAY" ":0")
        # Remove a variable by using null as the value:
        # (leaf "VAR" null)
      ])

      (plain "cursor" [
        # Change the theme and size of the cursor as well as set the
        # `XCURSOR_THEME` and `XCURSOR_SIZE` env variables.
        (leaf "xcursor-theme" "WhiteSur-cursors")
        (leaf "xcursor-size" 24)
      ])

      (flag "prefer-no-csd")
      (leaf "screenshot-path" null)

      (plain "hotkey-overlay" [
        (flag "skip-at-startup")
      ])

      # Animation settings.
      (plain "animations" [
        # Uncomment to turn off all animations.
        # (flag "off")

        # Slow down all animations by this factor. Values below 1 speed them up instead.
        # (leaf "slowdown" 3.0)

        # You can configure all individual animations.
        # Available settings are the same for all of them.
        # - off disables the animation.
        #
        # Niri supports two animation types: easing and spring.
        # You can set properties for only ONE of them.
        #
        # Easing has the following settings:
        # - duration-ms sets the duration of the animation in milliseconds.
        # - curve sets the easing curve. Currently, available curves
        #   are "ease-out-cubic" and "ease-out-expo".
        #
        # Spring animations work better with touchpad gestures, because they
        # take into account the velocity of your fingers as you release the swipe.
        # The parameters are less obvious and generally should be tuned
        # with trial and error. Notably, you cannot directly set the duration.
        # You can use this app to help visualize how the spring parameters
        # change the animation: https://flathub.org/apps/app.drey.Elastic
        #
        # A spring animation is configured like this:
        # - (leaf "spring" { damping-ratio=1.0; stiffness=1000; epsilon=0.0001; })
        #
        # The damping ratio goes from 0.1 to 10.0 and has the following properties:
        # - below 1.0: underdamped spring, will oscillate in the end.
        # - above 1.0: overdamped spring, won't oscillate.
        # - 1.0: critically damped spring, comes to rest in minimum possible time
        #    without oscillations.
        #
        # However, even with damping ratio = 1.0 the spring animation may oscillate
        # if "launched" with enough velocity from a touchpad swipe.
        #
        # Lower stiffness will result in a slower animation more prone to oscillation.
        #
        # Set epsilon to a lower value if the animation "jumps" in the end.
        #
        # The spring mass is hardcoded to 1.0 and cannot be changed. Instead, change
        # stiffness proportionally. E.g. increasing mass by 2x is the same as
        # decreasing stiffness by 2x.

        # Animation when switching workspaces up and down,
        # including after the touchpad gesture.
        (plain "workspace-switch" [
          # (flag "off")
          # (leaf "spring" { damping-ratio=1.0; stiffness=1000; epsilon=0.0001; })
        ])

        # All horizontal camera view movement:
        # - When a window off-screen is focused and the camera scrolls to it.
        # - When a new window appears off-screen and the camera scrolls to it.
        # - When a window resizes bigger and the camera scrolls to show it in full.
        # - And so on.
        (plain "horizontal-view-movement" [
          # (flag "off")
          # (leaf "spring" { damping-ratio=1.0; stiffness=800; epsilon=0.0001; })
        ])

        # Window opening animation. Note that this one has different defaults.
        (plain "window-open" [
          # (flag "off")
          # (leaf "duration-ms" 150)
          # (leaf "curve" "ease-out-expo")

          # Example for a slightly bouncy window opening:
          # (leaf "spring" { damping-ratio=0.8; stiffness=1000; epsilon=0.0001; })
        ])

        # Config parse error and new default config creation notification
        # open/close animation.
        (plain "config-notification-open-close" [
          # (flag "off")
          # (leaf "spring" { damping-ratio=0.6; stiffness=1000; epsilon=0.001; })
        ])
      ])

      # Window rules let you adjust behavior for individual windows.
      # They are processed in order of appearance in this file.

      (plain "window-rule" [
        (leaf "match" {
          app-id = "Plover: SVG Layout Display";
          title = "org.openstenoproject.python3";
        })
        (leaf "open-floating" true)
        (plain "focus-ring" [
          (leaf "width" 2)
          (leaf "active-color" "${secondary.focused}")
          (leaf "inactive-color" "${secondary.inactive}")
        ])
      ])

      (plain "window-rule" [
        (leaf "match" {
          app-id = "firefox";
        })
        (leaf "open-maximized" true)
      ])

      (plain "window-rule" [
        (leaf "match" {
          app-id = "emacs";
        })
        (leaf "open-maximized" true)
      ])

      (plain "binds" [
        # Keys consist of modifiers separated by + signs, followed by an XKB key name
        # in the end. To find an XKB name for a particular key, you may use a program
        # like wev.
        #
        # "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
        # when running as a winit window.
        #
        # Most actions that you can bind here can also be invoked programmatically with
        # `niri msg action do-something`.

        # Use this bind to toggle a column between normal and tabbed display.
        (plain "Mod+W" [(flag "toggle-column-tabbed-display")])

        # Mod-Shift-/, which is usually the same as Mod-?,
        # shows a list of important hotkeys.
        (plain "Mod+Shift+Slash" [(flag "show-hotkey-overlay")])

        # Suggested binds for running programs: terminal, app launcher, screen locker.
        # (plain "Mod+T" [(leaf "spawn" [""])])
        (plain "Mod+D" [(leaf "spawn" ["fuzzel"])])
        # (plain "Super+Alt+L" [(leaf "spawn" ["swaylock"])])

        # Example volume keys mappings for PipeWire & WirePlumber.
        (plain "XF86AudioRaiseVolume" [(leaf "spawn" ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"])])
        (plain "XF86AudioLowerVolume" [(leaf "spawn" ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"])])

        (plain "Mod+Q" [(flag "close-window")])

        (plain "Mod+Left" [(flag "focus-column-left")])
        (plain "Mod+Down" [(flag "focus-window-down")])
        (plain "Mod+Up" [(flag "focus-window-up")])
        (plain "Mod+Right" [(flag "focus-column-right")])
        (plain "Mod+H" [(flag "focus-column-left")])
        (plain "Mod+J" [(flag "focus-window-down")])
        (plain "Mod+K" [(flag "focus-window-up")])
        (plain "Mod+L" [(flag "focus-column-right")])

        (plain "Mod+Ctrl+Left" [(flag "move-column-left")])
        (plain "Mod+Ctrl+Down" [(flag "move-window-down")])
        (plain "Mod+Ctrl+Up" [(flag "move-window-up")])
        (plain "Mod+Ctrl+Right" [(flag "move-column-right")])
        (plain "Mod+Ctrl+H" [(flag "move-column-left")])
        (plain "Mod+Ctrl+J" [(flag "move-window-down")])
        (plain "Mod+Ctrl+K" [(flag "move-window-up")])
        (plain "Mod+Ctrl+L" [(flag "move-column-right")])

        # Alternative commands that move across workspaces when reaching
        # the first or last window in a column.
        # (plain "Mod+J"      [(flag "focus-window-or-workspace-down")])
        # (plain "Mod+K"      [(flag "focus-window-or-workspace-up")])
        # (plain "Mod+Ctrl+J" [(flag "move-window-down-or-to-workspace-down")])
        # (plain "Mod+Ctrl+K" [(flag "move-window-up-or-to-workspace-up")])

        (plain "Mod+Home" [(flag "focus-column-first")])
        (plain "Mod+End" [(flag "focus-column-last")])
        (plain "Mod+Ctrl+Home" [(flag "move-column-to-first")])
        (plain "Mod+Ctrl+End" [(flag "move-column-to-last")])

        (plain "Mod+Shift+Left" [(flag "focus-monitor-left")])
        (plain "Mod+Shift+Down" [(flag "focus-monitor-down")])
        (plain "Mod+Shift+Up" [(flag "focus-monitor-up")])
        (plain "Mod+Shift+Right" [(flag "focus-monitor-right")])
        (plain "Mod+Shift+H" [(flag "focus-monitor-left")])
        (plain "Mod+Shift+J" [(flag "focus-monitor-down")])
        (plain "Mod+Shift+K" [(flag "focus-monitor-up")])
        (plain "Mod+Shift+L" [(flag "focus-monitor-right")])

        (plain "Mod+Shift+Ctrl+Left" [(flag "move-column-to-monitor-left")])
        (plain "Mod+Shift+Ctrl+Down" [(flag "move-column-to-monitor-down")])
        (plain "Mod+Shift+Ctrl+Up" [(flag "move-column-to-monitor-up")])
        (plain "Mod+Shift+Ctrl+Right" [(flag "move-column-to-monitor-right")])
        (plain "Mod+Shift+Ctrl+H" [(flag "move-column-to-monitor-left")])
        (plain "Mod+Shift+Ctrl+J" [(flag "move-column-to-monitor-down")])
        (plain "Mod+Shift+Ctrl+K" [(flag "move-column-to-monitor-up")])
        (plain "Mod+Shift+Ctrl+L" [(flag "move-column-to-monitor-right")])

        # Alternatively, there are commands to move just a single window:
        # (plain "Mod+Shift+Ctrl+Left" [(flag "move-window-to-monitor-left")])
        # ...

        # And you can also move a whole workspace to another monitor:
        # (plain "Mod+Shift+Ctrl+Left" [(flag "move-workspace-to-monitor-left")])
        # ...

        (plain "Mod+Page_Down" [(flag "focus-workspace-down")])
        (plain "Mod+Page_Up" [(flag "focus-workspace-up")])
        (plain "Mod+U" [(flag "focus-workspace-down")])
        (plain "Mod+I" [(flag "focus-workspace-up")])
        (plain "Mod+Ctrl+Page_Down" [(flag "move-column-to-workspace-down")])
        (plain "Mod+Ctrl+Page_Up" [(flag "move-column-to-workspace-up")])
        (plain "Mod+Ctrl+U" [(flag "move-column-to-workspace-down")])
        (plain "Mod+Ctrl+I" [(flag "move-column-to-workspace-up")])

        # Alternatively, there are commands to move just a single window:
        # (plain "Mod+Ctrl+Page_Down" [(flag "move-window-to-workspace-down")])
        # ...

        (plain "Mod+Shift+Page_Down" [(flag "move-workspace-down")])
        (plain "Mod+Shift+Page_Up" [(flag "move-workspace-up")])
        (plain "Mod+Shift+U" [(flag "move-workspace-down")])
        (plain "Mod+Shift+I" [(flag "move-workspace-up")])

        # You can refer to workspaces by index. However, keep in mind that
        # niri is a dynamic workspace system, so these commands are kind of
        # "best effort". Trying to refer to a workspace index bigger than
        # the current workspace count will instead refer to the bottommost
        # (empty) workspace.
        #
        # For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
        # will all refer to the 3rd workspace.
        (plain "Mod+1" [(leaf "focus-workspace" 1)])
        (plain "Mod+2" [(leaf "focus-workspace" 2)])
        (plain "Mod+3" [(leaf "focus-workspace" 3)])
        (plain "Mod+4" [(leaf "focus-workspace" 4)])
        (plain "Mod+5" [(leaf "focus-workspace" 5)])
        (plain "Mod+6" [(leaf "focus-workspace" 6)])
        (plain "Mod+7" [(leaf "focus-workspace" 7)])
        (plain "Mod+8" [(leaf "focus-workspace" 8)])
        (plain "Mod+9" [(leaf "focus-workspace" 9)])
        (plain "Mod+Ctrl+1" [(leaf "move-column-to-workspace" 1)])
        (plain "Mod+Ctrl+2" [(leaf "move-column-to-workspace" 2)])
        (plain "Mod+Ctrl+3" [(leaf "move-column-to-workspace" 3)])
        (plain "Mod+Ctrl+4" [(leaf "move-column-to-workspace" 4)])
        (plain "Mod+Ctrl+5" [(leaf "move-column-to-workspace" 5)])
        (plain "Mod+Ctrl+6" [(leaf "move-column-to-workspace" 6)])
        (plain "Mod+Ctrl+7" [(leaf "move-column-to-workspace" 7)])
        (plain "Mod+Ctrl+8" [(leaf "move-column-to-workspace" 8)])
        (plain "Mod+Ctrl+9" [(leaf "move-column-to-workspace" 9)])

        # Alternatively, there are commands to move just a single window:
        # (plain "Mod+Ctrl+1" [(leaf "move-window-to-workspace" 1)])

        (plain "Mod+Comma" [(flag "consume-window-into-column")])
        (plain "Mod+Period" [(flag "expel-window-from-column")])

        # There are also commands that consume or expel a single window to the side.
        # (plain "Mod+BracketLeft"  [(flag "consume-or-expel-window-left")])
        # (plain "Mod+BracketRight" [(flag "consume-or-expel-window-right")])

        (plain "Mod+R" [(flag "switch-preset-column-width")])
        (plain "Mod+F" [(flag "maximize-column")])
        (plain "Mod+Shift+F" [(flag "fullscreen-window")])
        (plain "Mod+C" [(flag "center-column")])

        # Finer width adjustments.
        # This command can also:
        # * set width in pixels: "1000"
        # * adjust width in pixels: "-5" or "+5"
        # * set width as a percentage of screen width: "25%"
        # * adjust width as a percentage of screen width: "-10%" or "+10%"
        # Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        # (leaf "set-column-width" "100") will make the column occupy 200 physical screen pixels.
        (plain "Mod+Minus" [(leaf "set-column-width" "-10%")])
        (plain "Mod+Equal" [(leaf "set-column-width" "+10%")])

        # Finer height adjustments when in column with other windows.
        (plain "Mod+Shift+Minus" [(leaf "set-window-height" "-10%")])
        (plain "Mod+Shift+Equal" [(leaf "set-window-height" "+10%")])

        # Actions to switch layouts.
        # Note: if you uncomment these, make sure you do NOT have
        # a matching layout switch hotkey configured in xkb options above.
        # Having both at once on the same hotkey will break the switching,
        # since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        # (plain "Mod+Space"       [(leaf "switch-layout" "next")])
        # (plain "Mod+Shift+Space" [(leaf "switch-layout" "prev")])

        (plain "Print" [(flag "screenshot")])
        (plain "Ctrl+Print" [(flag "screenshot-screen")])
        (plain "Alt+Print" [(flag "screenshot-window")])

        # The quit action will show a confirmation dialog to avoid accidental exits.
        # If you want to skip the confirmation dialog, set the flag like so:
        # (plain "Mod+Shift+E" [(leaf "quit" { skip-confirmation=true; })])
        (plain "Mod+Shift+E" [(flag "quit")])

        (plain "Mod+Shift+P" [(flag "power-off-monitors")])

        # This debug bind will tint all surfaces green, unless they are being
        # directly scanned out. It's therefore useful to check if direct scanout
        # is working.
        # (plain "Mod+Shift+Ctrl+T" [(flag "toggle-debug-tint")])
      ])

      # Settings for debugging. Not meant for normal use.
      # These can change or stop working at any point with little notice.
      (plain "debug" [
        # Make niri take over its DBus services even if it's not running as a session.
        # Useful for testing screen recording changes without having to relogin.
        # The main niri instance will *not* currently take back the services; so you will
        # need to relogin in the end.
        # (flag "dbus-interfaces-in-non-session-instances")

        # Wait until every frame is done rendering before handing it over to DRM.
        # (flag "wait-for-frame-completion-before-queueing")

        # Enable direct scanout into overlay planes.
        # May cause frame drops during some animations on some hardware.
        # (flag "enable-overlay-planes")

        # Disable the use of the cursor plane.
        # The cursor will be rendered together with the rest of the frame.
        # (flag "disable-cursor-plane")

        # Override the DRM device that niri will use for all rendering.
        # (leaf "render-drm-device" "/dev/dri/renderD129")

        # Enable the color-transformations capability of the Smithay renderer.
        # May cause a slight decrease in rendering performance.
        # (flag "enable-color-transformations-capability")

        # Emulate zero (unknown) presentation time returned from DRM.
        # This is a thing on NVIDIA proprietary drivers, so this flag can be
        # used to test that we don't break too hard on those systems.
        # (flag "emulate-zero-presentation-time")
      ])
    ];
  }
