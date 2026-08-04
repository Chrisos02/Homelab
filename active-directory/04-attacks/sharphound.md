# SharpHound Enumeration

## Overview

SharpHound is used to collect Active Directory data for analysis in BloodHound.

---

## Execution

SharpHound was executed on the domain-joined Windows machine:

```
SharpHound.exe -c All
```

---

## Data Collected

* Users
* Groups
* Computers
* Permissions (ACLs)
* Sessions
* Trust relationships

---

## Output

A `.zip` file is generated:

```
20260318234032_BloodHound.zip
```

---

## Data Transfer

The `.zip` file is transferred to Kali Linux for analysis.

---

## Purpose

* Map relationships inside Active Directory
* Identify privilege escalation paths
* Analyze potential attack vectors




