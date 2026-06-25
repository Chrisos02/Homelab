# USB Storage Restriction

## Purpose
Block removable storage devices.

## Configuration
Computer Configuration -> Administrative Templates -> System -> Removable Storage Access

Enabled:
- All Removable Storage classes: Deny all access

Linked to OU_Computers.

## Validation
- gpupdate /force
- Restart client
- Connect USB storage
- Verify access denied

## Screenshots
- usb-gpo.png
- usb-blocked.png
