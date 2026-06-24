# Group Policy

## Overview

This section documents Group Policy Objects used in the Active Directory lab.

Group Policy is used to centrally manage settings for users and computers in a domain environment.

---

## What is GPO?

A Group Policy Object is a set of rules that can be applied to users or computers.

Examples:

- Password rules
- Desktop settings
- Drive mappings
- Security settings
- Windows Defender settings
- Blocking access to tools like Command Prompt

---

## Recommended First GPOs

### 1. Screen Lock Policy

Purpose:

Force users to lock automatically after inactivity.

Linked to:

```text
OU_Users
```

Example setting:

```text
User Configuration
→ Administrative Templates
→ Control Panel
→ Personalization
→ Screen saver timeout
```

---

### 2. Disable Command Prompt

Purpose:

Test that GPO applies to normal users.

Linked to:

```text
OU_Users
```

Setting:

```text
User Configuration
→ Administrative Templates
→ System
→ Prevent access to the command prompt
```

---

### 3. Windows Defender Settings

Purpose:

Manage baseline security settings for domain computers.

Linked to:

```text
OU_Computers
```

---

### 4. Drive Mapping

Purpose:

Map network drives based on group membership.

Example:

```text
IT_Users    → I:
HR_Users    → H:
Sales_Users → S:
```

This can be added later after creating file shares.

---

## Creating a GPO

Open:

```text
Server Manager → Tools → Group Policy Management
```

Right-click an OU, for example:

```text
OU_Users
```

Select:

```text
Create a GPO in this domain, and Link it here
```

---

## Testing GPO on Client

On the Windows 11 client, run:

```cmd
gpupdate /force
```

Check applied policies:

```cmd
gpresult /r
```

For a full HTML report:

```cmd
gpresult /h C:\gpresult.html
```

---

## GPO Plan

| GPO Name | Linked OU | Purpose | Status |
|---|---|---|---|
| Screen Lock Policy | OU_Users | Lock inactive sessions | Planned |
| Disable CMD | OU_Users | Restrict command prompt | Planned |
| Defender Baseline | OU_Computers | Security baseline | Planned |
| Drive Mapping | OU_Users | Map department shares | Planned |

---

## Key Concepts

- GPOs can apply to users or computers
- GPOs are linked to OUs
- DNS and domain join must work before GPO testing
- `gpupdate /force` refreshes policy
- `gpresult /r` shows applied policies

---

## Status

- [ ] Group Policy Management opened
- [ ] First GPO created
- [ ] GPO linked to OU
- [ ] GPO tested on User01
- [ ] `gpresult /r` verified

---

## Next Step

Create the first GPO and test it on the Windows 11 client.
