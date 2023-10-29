{ config
, ...
}: 
{ nix.allowedUnfree = [ "nvidia-x11" ]
; hardware = 
  { opengl = 
    { enable = true
    ; driSupport = true
    ; driSupport32Bit = true
    ; }
  ; nvidia=
    { prime.sync.enable = true
    ; modesetting.enable = true
    ; powerManagement.enable = false
    ; powerManagement.finegrained = false
    ; open = false
    ; nvidiaSettings = true
    ; package = config.boot.kernelPackages.nvidiaPackages.stable
    ; }
  ; }
; }
