#Ветка реестра Google Chrome
$HKLM_Chrome = "HKLM:\SOFTWARE\Policies\Google\Chrome"

#Черный список расширений
$ExtensionsBlockList = @(
    "*" #Запрещена установка всех расширений, которые не содержатся в белом списке
)

#Запрещаем установку расширений из списка
if ((Test-Path -LiteralPath "$HKLM_Chrome\ExtensionInstallBlocklist") -eq $true) { 
    Remove-Item "$HKLM_Chrome\ExtensionInstallBlocklist" -Recurse 
}
New-Item "$HKLM_Chrome\ExtensionInstallBlocklist"
$BlockListIndex = 0

foreach ($BlockExt in $ExtensionsBlockList) {
    $BlockListIndex += 1
    New-ItemProperty $HKLM_Chrome\ExtensionInstallBlocklist -Name "$BlockListIndex" -Value $BlockExt -PropertyType String
}



#Белый список расширений
$ExtensionsAllowList = @(
    "cjpalhdlnbpafiamejdnhcphjbkeiagm", #uBlock Origin
    "mokknliiomknodkdmpcellamkopbdmao", #FACEIT Enhancer
    "omghfjlpggmjjaagoclmmobgdodcjboh", #Browsec VPN
    "mbniclmhobmnbdlbpiphghaielnnpgdp", #Lightshot
    "cmeakgjggjdlcpncigglobpjbkabhmjl" #Steam Inventory Helper
)

#Разрешаем установку расширений из белого списка
if ((Test-Path -LiteralPath "$HKLM_Chrome\ExtensionInstallAllowlist") -eq $true) { 
    Remove-Item "$HKLM_Chrome\ExtensionInstallAllowlist" -Recurse 
}
New-Item "$HKLM_Chrome\ExtensionInstallAllowlist"
$AllowListIndex = 0

foreach ($AllowExt in $ExtensionsAllowList) {
    $AllowListIndex += 1
    New-ItemProperty $HKLM_Chrome\ExtensionInstallAllowlist -Name "$AllowListIndex" -Value $AllowExt -PropertyType String
}



#Список принудительной установки
$ExtensionsForceList = @(
    "cjpalhdlnbpafiamejdnhcphjbkeiagm", #uBlock Origin
    "mokknliiomknodkdmpcellamkopbdmao", #FACEIT Enhancer
    "omghfjlpggmjjaagoclmmobgdodcjboh", #Browsec VPN
    "mbniclmhobmnbdlbpiphghaielnnpgdp", #Lightshot
    "cmeakgjggjdlcpncigglobpjbkabhmjl" #Steam Inventory Helper
)

#Принудительная установка расширений из списка
if ((Test-Path -LiteralPath "$HKLM_Chrome\ExtensionInstallForcelist") -eq $true) { 
    Remove-Item "$HKLM_Chrome\ExtensionInstallForcelist" -Recurse 
}
New-Item "$HKLM_Chrome\ExtensionInstallForcelist"
$ForceListIndex = 0

foreach ($ForceExt in $ExtensionsForceList) {
    $ForceListIndex += 1
    New-ItemProperty $HKLM_Chrome\ExtensionInstallForcelist -Name "$ForceListIndex" -Value $ForceExt -PropertyType String
}



#Блокируем установку внешних расширений
if ((Get-ItemProperty "$HKLM_Chrome").BlockExternalExtensions -eq $true) { 
    Remove-ItemProperty $HKLM_Chrome -Name 'BlockExternalExtensions';
}
New-ItemProperty $HKLM_Chrome -Name 'BlockExternalExtensions' -Value 1 -PropertyType DWord;