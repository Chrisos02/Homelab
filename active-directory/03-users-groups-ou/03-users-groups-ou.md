# Users, Groups and Organizational Units

## Overview

This section documents the Active Directory structure created in the lab.

The purpose is to simulate a small business environment with different departments, standard users, admin accounts, and role-based security groups.

---

## Organizational Units

The following OUs were created:

```text
homelab.local
│
├── OU_Users
├── OU_Computers
├── OU_Admins
├── OU_Servers
└── OU_Groups
```

---

## Why Use OUs?

Organizational Units are used to organize Active Directory objects and apply Group Policy.

Examples:

- `OU_Users` stores standard users
- `OU_Admins` stores administrative accounts
- `OU_Computers` stores domain-joined client computers
- `OU_Groups` stores security groups
- `OU_Servers` can store server objects later

---

## Users

### Standard Users

| Display Name | Username | OU |
|---|---|---|
| Chris Osmundsen | chris.it | OU_Users |
| Ola Hansen | ola.hr | OU_Users |
| Kari Nordmann | kari.sales | OU_Users |

### Admin Users

| Display Name | Username | OU |
|---|---|---|
| Chris Admin | cadmin | OU_Admins |

---

## Security Groups

The following security groups were created in `OU_Groups`:

| Group | Purpose |
|---|---|
| IT_Users | Standard IT users |
| HR_Users | HR users |
| Sales_Users | Sales users |
| IT_Admins | IT administrator accounts |
| Servers_Users | Server access testing |

---

## Group Memberships

| User | Group |
|---|---|
| chris.it | IT_Users |
| ola.hr | HR_Users |
| kari.sales | Sales_Users |
| cadmin | IT_Admins |

---

## Status

- [x] OU_Users created
- [x] OU_Computers created
- [x] OU_Admins created
- [x] OU_Servers created
- [x] OU_Groups created
- [x] Standard users created
- [x] Admin user created
- [x] Security groups created
- [ ] Group memberships verified

---

## Next Step

Proceed to:

```text
../04-client-join/04-client-domain-join.md
```
