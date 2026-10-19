# macOS system settings for every host, applied by `darwin-rebuild switch`.
#
# Everything under system.defaults maps to a `defaults write` domain, so
# this is the declarative equivalent of clicking through System Settings.
# The values encode personal preferences: dark mode, a left-side Dock,
# fast key repeat, and a Finder that shows hidden files and extensions.
{pkgs, ...}: {
  system.stateVersion = 6;

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    menuExtraClock = {
      Show24Hour = false;
      ShowAMPM = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;

      InitialKeyRepeat = 10;
      KeyRepeat = 1;
      ApplePressAndHoldEnabled = false;

      _HIHideMenuBar = false;
      NSStatusItemSelectionPadding = 4;
      NSStatusItemSpacing = 4;

      "com.apple.swipescrolldirection" = false;
      "com.apple.mouse.tapBehavior" = 1;

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;

      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;

      AppleKeyboardUIMode = 3;
      "com.apple.sound.beep.feedback" = 0;
    };

    dock = {
      autohide = false;
      orientation = "left";
      tilesize = 24;

      persistent-apps = [];
      persistent-others = [
        {folder = "/Users/marykatemas/MARYKATEMAS/";}
        {folder = "/Users/marykatemas/Active/";}
        {folder = "/Users/marykatemas/Inactive/";}
      ];
      show-recents = false;

      wvous-tl-corner = 1;
      wvous-tr-corner = 1;
      wvous-bl-corner = 1;
      wvous-br-corner = 1;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
    };

    finder = {
      AppleShowAllFiles = true;
      NewWindowTarget = "Home";
      AppleShowAllExtensions = true;
      CreateDesktop = false;

      ShowPathbar = true;
      FXPreferredViewStyle = "Nlsv";
      FXDefaultSearchScope = "SCcf";
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;

      ShowStatusBar = true;
      QuitMenuItem = true;
      FXEnableExtensionChangeWarning = false;
    };

    universalaccess = {
      mouseDriverCursorSize = 2.5;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = true;
    };

    ".GlobalPreferences" = {
      "com.apple.mouse.scaling" = 1.0;
      "com.apple.sound.beep.sound" = "/System/Library/Sounds/Glass.aiff";
    };

    # Settings that have no first-class nix-darwin option go here and are
    # written straight to the named preferences domain.
    CustomUserPreferences = {
      NSGlobalDomain = {
        TISRomanSwitchState = 1;
        "com.apple.mouse.linear" = true;
      };
      # Enable exactly the US and Russian keyboard layouts. The layout IDs
      # are the ones macOS itself uses; 19456 is standard Russian. Hard
      # coding them keeps the input source list from drifting as keyboards
      # get added by hand.
      "com.apple.HIToolbox" = {
        AppleEnabledInputSources = [
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 0;
            "KeyboardLayout Name" = "U.S.";
          }
          {
            InputSourceKind = "Keyboard Layout";
            "KeyboardLayout ID" = 19456;
            "KeyboardLayout Name" = "Russian";
          }
        ];
      };
    };
  };
}
