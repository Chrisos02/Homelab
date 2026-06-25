# Kali Linux Setup

## Overview

Kali Linux is used as the attacker machine in this lab.

---

## Role

* Network enumeration
* Running offensive security tools
* Analyzing Active Directory

---

## Network Configuration

Kali is connected to the same host-only network as the domain:

* IP Address: `192.168.8.129`

---

## DNS Configuration

To resolve internal domain names, Kali was configured to use the domain controller:

```
/etc/resolv.conf
```

```
nameserver 192.168.10.10
```

---

## Connectivity Testing

Verified communication with:

```
ping 192.168.10.10
ping home.lab
```

---

## Tools Used

* BloodHound
* Neo4j

---

## Key Concepts

* Kali acts as an internal attacker
* DNS resolution is required for AD enumeration
* Proper network configuration is essential

