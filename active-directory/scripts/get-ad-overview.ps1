# AD Overview - Run on DC01 as Administrator

Write-Host "=== Organizational Units ===" -ForegroundColor Cyan
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName | Format-Table -AutoSize

Write-Host "=== Users ===" -ForegroundColor Cyan
Get-ADUser -Filter * | Select-Object Name, SamAccountName | Format-Table -AutoSize

Write-Host "=== Groups ===" -ForegroundColor Cyan
Get-ADGroup -Filter * | Select-Object Name | Format-Table -AutoSize

Write-Host "=== User Group Memberships ===" -ForegroundColor Cyan
Get-ADUser -Filter * -Properties MemberOf |
Select-Object Name, SamAccountName,
@{Name="Groups";Expression={
($_.MemberOf | ForEach-Object {
(Get-ADGroup $_).Name
}) -join ", "
}} | Format-Table -AutoSize
