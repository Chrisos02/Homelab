# 01 - Active Directory Domain Setup

## Overview

This section documents the Active Directory setup for the homelab.

It covers the Windows Server 2022 Domain Controller, DNS, DHCP, Organizational Units, users, security groups, and Windows 11 domain integration.

The goal was to build a small-business-style Active Directory environment using a separate internal network routed through OPNsense.

---

## Lab Environment

| Component | Details |
|---|---|
| Hypervisor | Proxmox VE |
| Firewall / Router | OPNsense |
| Domain Controller | DC01 |
| Server OS | Windows Server 2022 |
| Client | User01 |
| Client OS | Windows 11 |
| Domain | homelab.local |
| Internal Network | 192.168.20.0/24 |

---

## Network Design

The Active Directory environment runs on a separate internal network behind OPNsense.

| Machine | Role | IP Address |
|---|---|---|
| Home Router | Internet Gateway | 192.168.10.1 |
| Proxmox | Hypervisor | 192.168.10.200 |
| OPNsense WAN | External Interface | DHCP (192.168.10.x) |
| OPNsense LAN | Internal Gateway | 192.168.20.1 |
| DC01 | Domain Controller / DNS / DHCP | 192.168.20.10 |
| User01 | Windows 11 Client | DHCP (192.168.20.100–200) |

### Network Configuration

| Component | Configuration |
|---|---|
| Proxmox Bridge | vmbr0 |
| Internal Proxmox Bridge | vmbr1 |
| Internal Subnet | 192.168.20.0/24 |
| Default Gateway | 192.168.20.1 |
| DHCP Server | DC01 |
| DNS Server | DC01 (192.168.20.10) |

### Network Architecture

```text
Internet
   |
Home Router
192.168.10.1
   |
Proxmox VE
192.168.10.200
   |
   |-- vmbr0 (Home Network)
   |      |
   |      |-- OPNsense WAN
   |      |   DHCP: 192.168.10.x
   |
   |-- vmbr1 (Internal Lab Network)
          |
          |-- OPNsense LAN
          |   192.168.20.1
          |
          |-- DC01
          |   Windows Server 2022
          |   AD DS + DNS + DHCP
          |   192.168.20.10
          |
          |-- User01
              Windows 11 Client
              Domain Joined
              DHCP: 192.168.20.100–200
```

OPNsense provides routing and NAT between the internal lab network and the home network/internet.

The internal network uses a separate Proxmox bridge (`vmbr1`) without a physical network interface.

---

## 1. Domain Controller Setup

### Server Details

| Setting | Value |
|---|---|
| Hostname | DC01 |
| Operating System | Windows Server 2022 |
| Domain | homelab.local |
| IP Address | 192.168.20.10 |
| Subnet Mask | 255.255.255.0 |
| Default Gateway | 192.168.20.1 |
| Preferred DNS | 192.168.20.10 |

### Recommended VM Configuration

```text
CPU: 2 vCPU
RAM: 8 GB
Disk: 60 GB+
Network: VirtIO
CPU Type: host
```

### Static IP Configuration

DC01 uses a static IP address:

```text
IP Address:       192.168.20.10
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.20.1
Preferred DNS:    192.168.20.10
```

### Why DNS Points to Itself

The Domain Controller also runs DNS.

Domain clients need DNS to resolve Active Directory records such as:

```text
homelab.local
dc01.homelab.local
```

If DNS is misconfigured, domain join and domain authentication can fail.

---

## 2. Install AD DS and DNS

Using Server Manager:

1. Open **Server Manager**.
2. Select **Add Roles and Features**.
3. Choose **Role-based or feature-based installation**.
4. Select the local server.
5. Install:
   - Active Directory Domain Services
   - DNS Server
6. Complete the installation.

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

## 4. DHCP Configuration

Windows Server DC01 also provides DHCP services for the internal lab network.

OPNsense DHCP is disabled on the LAN interface to avoid having two DHCP servers on the same network.

### DHCP Scope

| Setting | Value |
|---|---|
| Scope Name | Homelab-LAN |
| Start IP Address | 192.168.20.100 |
| End IP Address | 192.168.20.200 |
| Subnet Mask | 255.255.255.0 |
| DHCP Server | 192.168.20.10 |

### DHCP Scope Options

| Option | Value | Purpose |
|---|---|---|
| 003 Router | 192.168.20.1 | Default Gateway |
| 006 DNS Servers | 192.168.20.10 | Domain Controller DNS |
| 015 DNS Domain Name | homelab.local | Active Directory Domain |

This allows domain clients to automatically receive their IP configuration, gateway, and DNS settings.

---

## 5. Active Directory Structure

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

## 6. Users

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

Using a separate admin account follows better security practice than using a standard user account for administrative tasks.

---

## 7. Security Groups

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

## 8. Windows 11 Client Setup

### Client Details

| Setting | Value |
|---|---|
| Hostname | User01 |
| Operating System | Windows 11 |
| IP Configuration | DHCP |
| IP Address Range | 192.168.20.100–200 |
| Default Gateway | 192.168.20.1 |
| DNS Server | 192.168.20.10 |
| Domain | homelab.local |

### Automatic IP Configuration

User01 is configured to obtain its IP address and DNS settings automatically through DHCP.

The DHCP server running on DC01 provides:

- IP address
- Subnet mask
- Default gateway
- DNS server
- DNS domain name

---

## 9. Connectivity and Domain Testing

The following tests were performed from User01.

### Test Gateway Connectivity

```cmd
ping 192.168.20.1
```

### Test Internet Connectivity

```cmd
ping 1.1.1.1
```

### Test DNS Resolution

```cmd
nslookup google.com
nslookup homelab.local
```

### Test Domain Controller Discovery

```cmd
nltest /dsgetdc:homelab.local
```

### Test Secure Channel

Run in PowerShell:

```powershell
Test-ComputerSecureChannel -Verbose
```

A successful result confirms that the client can communicate with its domain controller and maintain its domain secure channel.

---

## 10. Domain Join

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

6. Restart the client after a successful domain join.

Expected result:

```text
Welcome to the homelab.local domain
```

---

## 11. Domain Login

After restarting User01, domain login was tested with:

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

## Screenshots

 SOON

| Screenshot | Description |
|---|---|
| `dns-manager.png` | DNS Manager showing the `homelab.local` DNS zone |
| `ad-users-computers.png` | Active Directory Users and Computers |
| `ou-structure.png` | Organizational Units, users and security groups |
| `dns-confirmation.png` | Successful DNS lookup from User01 |
| `domain-join.png` | Confirmation that User01 successfully joined the domain |
| `domain-login.png` | Successful login using a domain user account |
| `domain-controller-discovery.png` | Successful domain controller discovery using `nltest` |
| `secure-channel-test.png` | Successful `Test-ComputerSecureChannel` result |

---
