# Network Setup

## Overview

This section documents the network configuration used for the Active Directory homelab.

The lab is running inside Proxmox and uses the same local network as the rest of the homelab.

---

## Network Type

- Virtualization: Proxmox VE
- Network Bridge: `vmbr0`
- Network Type: Bridged LAN
- Subnet: `192.168.10.0/24`

---

## Machines and IP Addresses

| Machine | Role | IP Address |
|---|---|---:|
| Router | Gateway | 192.168.10.1 |
| DC01 | Domain Controller / DNS | 192.168.10.10 |
| User01 | Windows 11 Client | 192.168.10.20 |

---

## Domain Controller Network Configuration

DC01 uses a static IP address.

```text
IP Address:       192.168.10.10
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

### Why DNS points to itself

The Domain Controller also runs DNS. Domain clients must be able to resolve domain records such as:

```text
homelab.local
dc01.homelab.local
```

If DNS is wrong, domain join and domain login will fail.

---

## Windows 11 Client Network Configuration

User01 uses a static IP address.

```text
IP Address:       192.168.10.20
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

---

## Connectivity Testing

Run these commands from the Windows 11 client:

```cmd
ping 192.168.10.10
ping dc01
nslookup homelab.local
```

---

## Next Step

Proceed to:

```text
../02-domain-controller/02-domain-controller.md
```
