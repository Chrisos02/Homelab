$groups = @(
    "IT_Users",
    "HR_Users",
    "Sales_Users",
    "IT_Admins",
    "Servers_Users"
)

foreach ($group in $groups) {
    New-ADGroup -Name $group -GroupScope Global -GroupCategory Security -Path "OU=OU_Groups,DC=homelab,DC=local"
}
