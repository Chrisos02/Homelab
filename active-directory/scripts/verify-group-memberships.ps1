# Verify Group Memberships - Run on DC01 as Administrator

Write-Host "=== Verifying Group Memberships ===" -ForegroundColor Cyan

$expected = @{
    "cosmundsen" = "IT_Users"
    "ola.hr"     = "HR_Users"
    "kari.sales" = "Sales_Users"
    "cadmin"     = "IT_Admins"
}

foreach ($user in $expected.Keys) {
    $group = $expected[$user]
    $member = Get-ADGroupMember -Identity $group | Where-Object { $_.SamAccountName -eq $user }
    if ($member) {
        Write-Host "OK: $user is in $group" -ForegroundColor Green
    } else {
        Write-Host "MISSING: $user is NOT in $group" -ForegroundColor Red
    }
}
