# Windows 11 Client Domain Join

## Overview

This section documents how the Windows 11 client was joined to the Active Directory domain.

The Windows 11 client is used to test domain login, DNS, user authentication, and Group Policy.

---

## Client Details

| Setting | Value |
|---|---|
| Hostname | User01 |
| Operating System | Windows 11 |
| IP Address | 192.168.10.20 |
| DNS Server | 192.168.10.10 |
| Domain | homelab.local |

---

## Step 1: Configure Static IP

The Windows 11 client was configured with:

```text
IP Address:       192.168.10.20
Subnet Mask:      255.255.255.0
Default Gateway:  192.168.10.1
Preferred DNS:    192.168.10.10
```

---

## Step 2: Test Connectivity

Run these commands on the Windows 11 client:

```cmd
ping 192.168.10.10
ping dc01
nslookup homelab.local
```

Expected result:

- `192.168.10.10` replies
- `dc01` resolves
- `homelab.local` resolves

---

## Step 3: Rename Client

The Windows 11 client was renamed to:

```text
User01
```

Restart the client after renaming.

---

## Step 4: Join Domain

Open:

```text
Settings → System → About → Advanced system settings
```

Then:

```text
Computer Name → Change
```

Select:

```text
Domain
```

Enter:

```text
homelab.local
```

---

## Step 5: Authenticate

When prompted, use domain administrator credentials:

```text
homelab\Administrator
```

or:

```text
Administrator@homelab.local
```

---

## Step 6: Restart

After successful domain join, restart the Windows 11 client.

Expected message:

```text
Welcome to the homelab.local domain
```

---

## Step 7: Log in as Domain User

Log in using:

```text
homelab\cosmundsen
```

or:

```text
cosmundsen@homelab.local
```

---

## Step 8: Move Computer Object

After joining the domain, the computer object usually appears in the default `Computers` container.

Move it to:

```text
OU_Computers
```

Expected structure:

```text
OU_Computers
└── User01
```

---

## Troubleshooting

### Problem: Domain cannot be contacted

Check DNS:

```cmd
ipconfig /all
nslookup homelab.local
```

The client DNS must be:

```text
192.168.10.10
```

### Problem: Cannot ping DC01

Check:

- IP address
- Proxmox network bridge
- Windows Firewall
- Same subnet

### Problem: Wrong credentials

Use:

```text
homelab\Administrator
```

or:

```text
Administrator@homelab.local
```

---

## Key Concepts

- Domain join requires DNS to work
- The client must use the Domain Controller as DNS
- Domain users can log in to domain-joined machines
- Computer objects should be organized into OUs

---

## Status

- [x] Client IP configured
- [x] DNS points to DC01
- [x] Client renamed to User01
- [ ] Client joined to domain
- [ ] Domain user login tested
- [ ] Computer moved to OU_Computers

---

## Next Step

Proceed to:

```text
../05-group-policy/05-group-policy.md
```
