_: {self, pkgs, ...}:
{
  de.keyboard.custom = {
    enable = true;
    keyboards = {
      tkl = {
        name = "tkl";
        device = "/dev/input/by-id/usb-SONiX_USB_DEVICE-event-kbd";
        composeKey = "ralt";
        fallthrough = true;
        allowCommands = false;
        config = ../config/keyboard/workman_tkl.kbd;
      };
      internal = {
        name = "internal";
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        composeKey = "ralt";
        fallthrough = true;
        allowCommands = false;
        config = ../config/keyboard/workman_laptop.kbd;
      };
    };
  };
}