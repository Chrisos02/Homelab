# 01 - Active Directory Domain Setup

## Overview

This section documents the initial Active Directory setup for the homelab.

It combines the original network setup, domain controller installation, users/groups/OU structure, and Windows 11 client domain join into one complete guide.

The goal was to build a realistic small-business Active Directory environment using Windows Server 2022 and a Windows 11 domain client.

---

## Lab Environment

| Component | Details |
|---|---|
| Hypervisor | Proxmox VE |
| Domain Controller | DC01 |
| Server OS | Windows Server 2022 |
| Client | User01 |
| Client OS | Windows 11 |
| Domain | homelab.local |
| Network | 192.168.10.0/24 |

---

## Network Design

| Machine | Role | IP Address |
|---|---|---|
| Router | Gateway | 192.168.10.1 |
| DC01 | Domain Controller / DNS | 192.168.10.10 |
| User01 | Windows 11 Client | 192.168.10.20 |

### Network Type

- Proxmox network bridge: `vmbr0`
- Network type: Bridged LAN
- Subnet: `192.168.10.0/24`

---

## Architecture

```text
Internet
   |
Router / Gateway
192.168.10.1
   |
Proxmox VE
   |
   |-- DC01
   |   Windows Server 2022
   |   AD DS + DNS
   |   192.168.10.10
   |
   |-- User01
       Windows 11 Client
       Domain joined
       192.168.10.20
```

---

## 1. Domain Controller Setup

### Server Details

| Setting | Value |
|---|---|
| Hostname | DC01 |
| Operating System | Windows Server 2022 |
| Domain | homelab.local |
| IP Address | 192.168.10.10 |
| DNS | 192.168.10.10 |

### Recommended VM Configuration

```text
CPU: 2 vCPU
RAM: 8 GB
Disk: 60 GB+
Network: VirtIO
CPU Type: host
```

### Static IP Configuration

DC01 was configured with a static IP address:

```text
IP Address:       192.168.10.10
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

### Why DNS Points to Itself

The Domain Controller also runs DNS. Domain clients need DNS to resolve domain records such as:

```text
homelab.local
dc01.homelab.local
```

If DNS is misconfigured, domain join and domain login will fail.

---

## 2. Install AD DS and DNS

Using Server Manager:

1. Open **Server Manager**
2. Select **Add Roles and Features**
3. Choose **Role-based or feature-based installation**
4. Select the local server
5. Install:
   - Active Directory Domain Services
   - DNS Server
6. Complete the installation

---

## 3. Promote Server to Domain Controller

After AD DS was installed:

1. Click the yellow notification flag in Server Manager.
2. Select **Promote this server to a domain controller**.
3. Choose:

```text
Add a new forest
```

4. Root domain name:

```text
homelab.local
```

5. Keep DNS enabled.
6. Set a DSRM password.
7. Complete the installation.
8. Restart the server.

---

## 4. Active Directory Structure

The following Organizational Units were created:

```text
homelab.local
│
├── OU_Users
├── OU_Computers
├── OU_Admins
├── OU_Servers
└── OU_Groups
```

### OU Purpose

| OU | Purpose |
|---|---|
| OU_Users | Standard user accounts |
| OU_Admins | Administrative accounts |
| OU_Computers | Domain-joined client computers |
| OU_Servers | Server objects |
| OU_Groups | Security groups |

---

## 5. Users

### Standard Users

| Display Name | Username | OU | Role |
|---|---|---|---|
| Chris Olsen | chris.it | OU_Users | IT user |
| Ola Hansen | ola.hr | OU_Users | HR user |
| Kari Nordmann | kari.sales | OU_Users | Sales user |

### Admin User

| Display Name | Username | OU | Purpose |
|---|---|---|---|
| Chris Admin | cadmin | OU_Admins | Separate privileged account |

Using a separate admin account follows better practice than using a normal user account for administrative tasks.

---

## 6. Security Groups

The following security groups were created in `OU_Groups`:

| Group | Purpose |
|---|---|
| IT_Users | Standard IT users |
| HR_Users | HR department users |
| Sales_Users | Sales department users |
| IT_Admins | IT administrator accounts |
| Servers_Users | Server-related access testing |

### Group Memberships

| User | Group |
|---|---|
| chris.it | IT_Users |
| ola.hr | HR_Users |
| kari.sales | Sales_Users |
| cadmin | IT_Admins |

---

## 7. Windows 11 Client Setup

### Client Details

| Setting | Value |
|---|---|
| Hostname | User01 |
| Operating System | Windows 11 |
| IP Address | 192.168.10.20 |
| DNS Server | 192.168.10.10 |
| Domain | homelab.local |

### Static IP Configuration

```text
IP Address:       192.168.10.20
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

---

## 8. Connectivity Testing

Before joining the domain, the client was tested with:

```cmd
ping 192.168.10.10
ping dc01
nslookup homelab.local
```

Expected results:

- DC01 replies to ping.
- `dc01` resolves correctly.
- `homelab.local` resolves correctly.
- DNS server points to `192.168.10.10`.

---

## 9. Domain Join

On the Windows 11 client:

1. Open:

```text
Settings → System → About → Advanced system settings
```

2. Go to:

```text
Computer Name → Change
```

3. Select:

```text
Domain
```

4. Enter:

```text
homelab.local
```

5. Authenticate using domain administrator credentials:

```text
homelab\Administrator
```

or:

```text
Administrator@homelab.local
```

6. Restart the client after successful domain join.

Expected result:

```text
Welcome to the homelab.local domain
```

---

## 10. Domain Login

After restarting `User01`, domain login was tested with:

```text
homelab\chris.it
```

or:

```text
chris.it@homelab.local
```

This confirmed that:

- The client was successfully joined to the domain.
- Domain authentication worked.
- DNS was configured correctly.
- The domain controller was reachable.

---

## Validation Checklist

| Task | Status |
|---|---|
| Windows Server 2022 installed | Done |
| DC01 static IP configured | Done |
| AD DS installed | Done |
| DNS installed | Done |
| New forest created | Done |
| Domain `homelab.local` created | Done |
| OUs created | Done |
| Users created | Done |
| Security groups created | Done |
| Group memberships configured | Done |
| Windows 11 client configured | Done |
| Client joined to domain | Done |
| Domain login tested | Done |

---

## Screenshots

Add screenshots to the `screenshots/` folder using these names:

| Screenshot | Description |
|---|---|
| `server-manager.png` | Server Manager on DC01 |
| `dc01-ip-configuration.png` | Static IP configuration for DC01 |
| `ad-ds-installation.png` | AD DS role installation |
| `domain-creation.png` | Domain creation / promotion wizard |
| `dns-manager.png` | DNS Manager showing `homelab.local` |
| `ad-users-computers.png` | Active Directory Users and Computers |
| `ou-structure.png` | OU structure with users and groups |
| `user01-ip-configuration.png` | Static IP configuration for User01 |
| `dns-confirmation.png` | Ping/nslookup test from User01 |
| `domain-join.png` | Successful domain join |
| `domain-login.png` | Successful login as domain user |

---

## Skills Demonstrated

- Windows Server 2022 administration
- Proxmox virtual machine deployment
- Static IP configuration
- Active Directory Domain Services
- DNS administration
- Domain Controller promotion
- Forest and domain creation
- Organizational Unit design
- User and security group management
- Windows 11 domain join
- Domain authentication testing
- Infrastructure documentation

---

## Original Notes

The original step-by-step files are preserved in:

```text
original-notes/
├── 01-network-setup.md
├── 02-domain-controller.md
├── 03-users-groups-ou.md
└── 04-client-domain-join.md
```
