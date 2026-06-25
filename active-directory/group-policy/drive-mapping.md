# Drive Mapping

## Purpose

Automatically map department network drives based on Active Directory group membership.

## Configuration

| Group | Drive | Path |
|---|---|---|
| HR_Users | H: | `\\DC01\HR` |
| IT_Users | I: | `\\DC01\IT` |
| Sales_Users | S: | `\\DC01\Sales` |

## Validation

The setup was tested by logging into `User01` as domain users.

- `ola.hr` received H:
- `chris.it` received I:
- `kari.sales` received S:

## Screenshots

![Drive Mapping GPO](screenshots/drive-mapping-gpo.png)

## Ola Hansen (Sales)
![HR Drive Result](screenshots/hr-drive-result.png)

## Chris Olsen (IT)
![IT Drive Result](screenshots/it-drive-result.png)

## Kari Nordmann (HR)
![Sales Drive Result](screenshots/sales-drive-result.png)
