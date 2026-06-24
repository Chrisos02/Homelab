Write-Host "=== Organizational Units ===" -ForegroundColor Cyan
Get-ADOrganizationalUnit -Filter * | Select Name, DistinguishedName | Format-Table -AutoSize

Write-Host "`n=== Users ===" -ForegroundColor Cyan
Get-ADUser -Filter * | Select Name, SamAccountName, DistinguishedName | Format-Table -AutoSize

Write-Host "`n=== Groups ===" -ForegroundColor Cyan
Get-ADGroup -Filter * | Select Name, GroupCategory, GroupScope | Format-Table -AutoSize

Write-Host "`n=== User Group Memberships ===" -ForegroundColor Cyan
Get-ADUser -Filter * -Properties MemberOf |
Select Name,SamAccountName,
@{Name="Groups";Expression={
($_.MemberOf | ForEach-Object {
(Get-ADGroup $_).Name
}) -join ", "
}} | Format-Table -AutoSize
