# USB Storage Restriction

## Purpose

Block removable storage devices to reduce the risk of malware introduction and data exfiltration.

## Configuration

Enabled:

```text
All Removable Storage classes: Deny all access
```

Recommended link target:

```text
OU_Computers
```

## Screenshot

![USB Disable Policy](screenshots/usb-disable-policy.png)

## Validation

Run:

```cmd
gpupdate /force
```

Restart the client, connect a USB storage device, and verify that access is denied.
