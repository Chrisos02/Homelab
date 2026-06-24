# Verify AD User Group Memberships
# Run this on DC01 as Administrator

Get-ADUser -Filter * -Properties MemberOf |
Select Name,SamAccountName,
@{Name="Groups";Expression={
($_.MemberOf | ForEach-Object {
(Get-ADGroup $_).Name
}) -join ", "
}} | Format-Table -AutoSize
