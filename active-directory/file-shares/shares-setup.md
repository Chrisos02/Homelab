# SMB Share Setup

## Purpose

Department folders were created on the Domain Controller and published as SMB shares.

## Local Folder Structure

```
C:\Shares
├── HR
├── IT
└── Sales
```

## Published Shares

| Share | Path |
|------|------|
| HR | \\DC01\HR |
| IT | \\DC01\IT |
| Sales | \\DC01\Sales |

## Validation

- Browse to each UNC path.
- Verify the share is reachable from a domain-joined client.

## Suggested Screenshots

- shares-folder.png
- share-properties-hr.png
- share-properties-it.png
- share-properties-sales.png
