# Domain Controller Setup

## Overview

This section documents how the Windows Server 2022 machine was configured as the Domain Controller for the lab.

The Domain Controller is responsible for:

- Authentication
- Active Directory Domain Services
- DNS
- User and group management
- Group Policy

---

## Server Details

| Setting | Value |
|---|---|
| Hostname | DC01 |
| Operating System | Windows Server 2022 |
| Domain | homelab.local |
| IP Address | 192.168.10.10 |
| DNS | 192.168.10.10 |

---

## Step 1: Install Windows Server 2022

Windows Server 2022 was installed as a virtual machine in Proxmox.

Recommended VM configuration:

```text
CPU: 2 vCPU
RAM: 8 GB
Disk: 60 GB+
Network: VirtIO
CPU Type: host
```

---

## Step 2: Rename Server

The server was renamed to:

```text
DC01
```

The server was restarted after renaming.

---

## Step 3: Configure Static IP

The following static IP configuration was applied:

```text
IP Address:       192.168.10.10
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

---

## Step 4: Install Active Directory Domain Services

Using Server Manager:

1. Open **Server Manager**
2. Click **Add Roles and Features**
3. Select **Role-based or feature-based installation**
4. Select the local server
5. Install:
   - Active Directory Domain Services
   - DNS Server
6. Complete installation

---

## Step 5: Promote Server to Domain Controller

After installing AD DS:

1. Click the yellow notification flag in Server Manager
2. Select **Promote this server to a domain controller**
3. Choose:

```text
Add a new forest
```

4. Root domain name:

```text
homelab.local
```

5. Keep default forest and domain functional levels
6. Keep DNS enabled
7. Set a DSRM password
8. Complete installation
9. Restart server

---

## Status

- [x] Windows Server 2022 installed
- [x] Server renamed to DC01
- [x] Static IP configured
- [x] AD DS installed
- [x] DNS installed
- [x] Domain created
- [x] Domain Controller verified

---

## Next Step

Proceed to:

```text
../03-users-groups-ou/03-users-groups-ou.md
```
