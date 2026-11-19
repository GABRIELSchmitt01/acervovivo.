[CmdletBinding()]
param(
    [string]$ApplicationId = "com.gabrielschmitt.acervovivo"
)

$ErrorActionPreference = "Stop"

$ProjectName = "acervovivo"
if ($ApplicationId -notmatch '^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$TargetApi = 36
$NewLine = [Environment]::NewLine

function Replace-ExactlyOne {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$Pattern,
        [Parameter(Mandatory = $true)][string]$Replacement,
        [Parameter(Mandatory = $true)][string]$Description
    )

    $count = [regex]::Matches($Text, $Pattern).Count
    if ($count -ne 1) {
        throw "Expected exactly one '$Description' entry, found $count. Review the generated Android files before continuing."
    }

    return [regex]::Replace($Text, $Pattern, $Replacement, 1)
}

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$appDirectory = Join-Path $repositoryRoot "app_flutter"
$pubspecPath = Join-Path $appDirectory "pubspec.yaml"

if (-not (Test-Path $pubspecPath)) {
    throw "Could not find app_flutter/pubspec.yaml. Run this script from the cloned AcervoVivo repository."
}

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter was not found in PATH. Install/configure Flutter, reopen PowerShell, and run this script again."
}

Write-Host ""
Write-Host "AcervoVivo - Android preparation" -ForegroundColor Cyan
Write-Host "Application ID: $ApplicationId (suggested default; confirm before first Play Store publication)"
Write-Host "Target API: $TargetApi"
Write-Host ""

$versionOutput = (& flutter --version 2>&1 | Out-String)
Write-Host $versionOutput
if ($LASTEXITCODE -ne 0) {
    throw "Could not read the installed Flutter version."
}

$versionMatch = [regex]::Match($versionOutput, 'Flutter\s+(\d+\.\d+\.\d+)')
if (-not $versionMatch.Success -or [version]$versionMatch.Groups[1].Value -lt [version]"3.47.7") {
    throw "Flutter 3.47.7 or newer is required. Run 'flutter upgrade' and try again."
}

Push-Location $appDirectory
try {
    if (-not (Test-Path "android")) {
        Write-Host "Generating the native Android project with Flutter..." -ForegroundColor Yellow
        & flutter create --platforms=android --org $Organization --project-name $ProjectName --android-language kotlin .
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter could not generate the Android platform files."
        }
    }
    else {
        Write-Host "An android folder already exists. Keeping it and applying the release configuration." -ForegroundColor Yellow
    }

    $gradlePath = Join-Path $appDirectory "android/app/build.gradle.kts"
    if (-not (Test-Path $gradlePath)) {
        throw "android/app/build.gradle.kts was not generated. Check the Flutter Android template and do not build yet."
    }

    $gradle = Get-Content -Raw -Encoding UTF8 $gradlePath
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)namespace\s*=\s*".*?"\s*$' -Replacement ('$1namespace = "' + $ApplicationId + '"') -Description "namespace"
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)applicationId\s*=\s*".*?"\s*$' -Replacement ('$1applicationId = "' + $ApplicationId + '"') -Description "applicationId"
    # Keep compileSdk managed by the installed Flutter SDK; enforce the Play target API separately.
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)targetSdk\s*=\s*.*$' -Replacement ('$1targetSdk = ' + $TargetApi) -Description "targetSdk"
    Set-Content -Path $gradlePath -Value $gradle -Encoding UTF8

    $manifestPath = Join-Path $appDirectory "android/app/src/main/AndroidManifest.xml"
    if (-not (Test-Path $manifestPath)) {
        throw "AndroidManifest.xml was not generated."
    }

    $manifest = Get-Content -Raw -Encoding UTF8 $manifestPath
    $manifest = Replace-ExactlyOne -Text $manifest -Pattern 'android:label="[^"]*"' -Replacement 'android:label="AcervoVivo"' -Description "application label"

    if ($manifest -notmatch 'android\.permission\.INTERNET') {
        $manifest = Replace-ExactlyOne -Text $manifest -Pattern '(<manifest\b[^>]*>)' -Replacement ('$1' + $NewLine + '    <uses-permission android:name="android.permission.INTERNET" />') -Description "manifest root"
    }
    Set-Content -Path $manifestPath -Value $manifest -Encoding UTF8

    $kotlinRoot = Join-Path $appDirectory "android/app/src/main/kotlin"
    $mainActivityFiles = @(Get-ChildItem -Path $kotlinRoot -Filter "MainActivity.kt" -Recurse -File -ErrorAction SilentlyContinue)
    if ($mainActivityFiles.Count -ne 1) {
        throw "Expected one MainActivity.kt under android/app/src/main/kotlin, found $($mainActivityFiles.Count). Check the Android project before building."
    }

    $packageDirectory = Join-Path $kotlinRoot ($ApplicationId.Replace(".", [IO.Path]::DirectorySeparatorChar))
    New-Item -ItemType Directory -Path $packageDirectory -Force | Out-Null
    $mainActivityPath = Join-Path $packageDirectory "MainActivity.kt"
    $activityContent = Get-Content -Raw -Encoding UTF8 $mainActivityFiles[0].FullName
    $activityContent = Replace-ExactlyOne -Text $activityContent -Pattern '(?m)^package\s+[A-Za-z0-9_.]+\s*$' -Replacement ("package " + $ApplicationId) -Description "MainActivity package"
    Set-Content -Path $mainActivityPath -Value $activityContent -Encoding UTF8
    if ($mainActivityFiles[0].FullName -ne $mainActivityPath) {
        Remove-Item -Path $mainActivityFiles[0].FullName -Force
    }

    # Keep release signing material out of Git.
    $androidGitignore = Join-Path $appDirectory "android/.gitignore"
    if (Test-Path $androidGitignore) {
        $ignoreContent = Get-Content -Raw -Encoding UTF8 $androidGitignore
    }
    else {
        $ignoreContent = ""
    }

    $requiredIgnoreRules = @(
        "/key.properties",
        "**/*.jks",
        "**/*.keystore"
    )
    foreach ($rule in $requiredIgnoreRules) {
        if ($ignoreContent -notmatch [regex]::Escape($rule)) {
            $ignoreContent = $ignoreContent.TrimEnd() + $NewLine + $rule + $NewLine
        }
    }
    Set-Content -Path $androidGitignore -Value $ignoreContent -Encoding UTF8

    Write-Host ""
    Write-Host "Android project prepared." -ForegroundColor Green
    Write-Host "Application ID: $ApplicationId"
    Write-Host "targetSdk: $TargetApi (compileSdk remains managed by Flutter)"
    Write-Host "App label: AcervoVivo"
    Write-Host "Internet permission: declared"
    Write-Host "Launcher icon: Flutter default icon remains in place for now."
    Write-Host ""
    Write-Host "Next checks (after installing Android Studio + Android SDK Platform $TargetApi):" -ForegroundColor Cyan
    Write-Host "  flutter doctor -v"
    Write-Host "  flutter doctor --android-licenses"
    Write-Host "  flutter pub get"
    Write-Host "  flutter build apk --debug"
    Write-Host ""
    Write-Host "Do not create or commit the upload keystore yet. The release key must be stored safely and kept out of Git."
}
finally {
    Pop-Location
}
) {
    throw "Invalid Application ID. Use reverse-domain form, for example com.company.acervovivo."
}
$lastDot = $ApplicationId.LastIndexOf('.')
$Organization = $ApplicationId.Substring(0, $lastDot)
$TargetApi = 36
$NewLine = [Environment]::NewLine

function Replace-ExactlyOne {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$Pattern,
        [Parameter(Mandatory = $true)][string]$Replacement,
        [Parameter(Mandatory = $true)][string]$Description
    )

    $count = [regex]::Matches($Text, $Pattern).Count
    if ($count -ne 1) {
        throw "Expected exactly one '$Description' entry, found $count. Review the generated Android files before continuing."
    }

    return [regex]::Replace($Text, $Pattern, $Replacement, 1)
}

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$appDirectory = Join-Path $repositoryRoot "app_flutter"
$pubspecPath = Join-Path $appDirectory "pubspec.yaml"

if (-not (Test-Path $pubspecPath)) {
    throw "Could not find app_flutter/pubspec.yaml. Run this script from the cloned AcervoVivo repository."
}

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    throw "Flutter was not found in PATH. Install/configure Flutter, reopen PowerShell, and run this script again."
}

Write-Host ""
Write-Host "AcervoVivo - Android preparation" -ForegroundColor Cyan
Write-Host "Application ID: $ApplicationId"
Write-Host "Target API: $TargetApi"
Write-Host ""

$versionOutput = (& flutter --version 2>&1 | Out-String)
Write-Host $versionOutput
if ($LASTEXITCODE -ne 0) {
    throw "Could not read the installed Flutter version."
}

$versionMatch = [regex]::Match($versionOutput, 'Flutter\s+(\d+\.\d+\.\d+)')
if (-not $versionMatch.Success -or [version]$versionMatch.Groups[1].Value -lt [version]"3.47.7") {
    throw "Flutter 3.47.7 or newer is required. Run 'flutter upgrade' and try again."
}

Push-Location $appDirectory
try {
    if (-not (Test-Path "android")) {
        Write-Host "Generating the native Android project with Flutter..." -ForegroundColor Yellow
        & flutter create --platforms=android --org $Organization --project-name $ProjectName --android-language kotlin .
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter could not generate the Android platform files."
        }
    }
    else {
        Write-Host "An android folder already exists. Keeping it and applying the release configuration." -ForegroundColor Yellow
    }

    $gradlePath = Join-Path $appDirectory "android/app/build.gradle.kts"
    if (-not (Test-Path $gradlePath)) {
        throw "android/app/build.gradle.kts was not generated. Check the Flutter Android template and do not build yet."
    }

    $gradle = Get-Content -Raw -Encoding UTF8 $gradlePath
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)namespace\s*=\s*".*?"\s*$' -Replacement ('$1namespace = "' + $ApplicationId + '"') -Description "namespace"
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)applicationId\s*=\s*".*?"\s*$' -Replacement ('$1applicationId = "' + $ApplicationId + '"') -Description "applicationId"
    # Keep compileSdk managed by the installed Flutter SDK; enforce the Play target API separately.
    $gradle = Replace-ExactlyOne -Text $gradle -Pattern '(?m)^(\s*)targetSdk\s*=\s*.*$' -Replacement ('$1targetSdk = ' + $TargetApi) -Description "targetSdk"
    Set-Content -Path $gradlePath -Value $gradle -Encoding UTF8

    $manifestPath = Join-Path $appDirectory "android/app/src/main/AndroidManifest.xml"
    if (-not (Test-Path $manifestPath)) {
        throw "AndroidManifest.xml was not generated."
    }

    $manifest = Get-Content -Raw -Encoding UTF8 $manifestPath
    $manifest = Replace-ExactlyOne -Text $manifest -Pattern 'android:label="[^"]*"' -Replacement 'android:label="AcervoVivo"' -Description "application label"

    if ($manifest -notmatch 'android\.permission\.INTERNET') {
        $manifest = Replace-ExactlyOne -Text $manifest -Pattern '(<manifest\b[^>]*>)' -Replacement ('$1' + $NewLine + '    <uses-permission android:name="android.permission.INTERNET" />') -Description "manifest root"
    }
    Set-Content -Path $manifestPath -Value $manifest -Encoding UTF8

    $kotlinRoot = Join-Path $appDirectory "android/app/src/main/kotlin"
    $mainActivityFiles = @(Get-ChildItem -Path $kotlinRoot -Filter "MainActivity.kt" -Recurse -File -ErrorAction SilentlyContinue)
    if ($mainActivityFiles.Count -ne 1) {
        throw "Expected one MainActivity.kt under android/app/src/main/kotlin, found $($mainActivityFiles.Count). Check the Android project before building."
    }

    $packageDirectory = Join-Path $kotlinRoot ($ApplicationId.Replace(".", [IO.Path]::DirectorySeparatorChar))
    New-Item -ItemType Directory -Path $packageDirectory -Force | Out-Null
    $mainActivityPath = Join-Path $packageDirectory "MainActivity.kt"
    $activityContent = Get-Content -Raw -Encoding UTF8 $mainActivityFiles[0].FullName
    $activityContent = Replace-ExactlyOne -Text $activityContent -Pattern '(?m)^package\s+[A-Za-z0-9_.]+\s*$' -Replacement ("package " + $ApplicationId) -Description "MainActivity package"
    Set-Content -Path $mainActivityPath -Value $activityContent -Encoding UTF8
    if ($mainActivityFiles[0].FullName -ne $mainActivityPath) {
        Remove-Item -Path $mainActivityFiles[0].FullName -Force
    }

    # Keep release signing material out of Git.
    $androidGitignore = Join-Path $appDirectory "android/.gitignore"
    if (Test-Path $androidGitignore) {
        $ignoreContent = Get-Content -Raw -Encoding UTF8 $androidGitignore
    }
    else {
        $ignoreContent = ""
    }

    $requiredIgnoreRules = @(
        "/key.properties",
        "**/*.jks",
        "**/*.keystore"
    )
    foreach ($rule in $requiredIgnoreRules) {
        if ($ignoreContent -notmatch [regex]::Escape($rule)) {
            $ignoreContent = $ignoreContent.TrimEnd() + $NewLine + $rule + $NewLine
        }
    }
    Set-Content -Path $androidGitignore -Value $ignoreContent -Encoding UTF8

    Write-Host ""
    Write-Host "Android project prepared." -ForegroundColor Green
    Write-Host "Application ID: $ApplicationId"
    Write-Host "targetSdk: $TargetApi (compileSdk remains managed by Flutter)"
    Write-Host "App label: AcervoVivo"
    Write-Host "Internet permission: declared"
    Write-Host "Launcher icon: Flutter default icon remains in place for now."
    Write-Host ""
    Write-Host "Next checks (after installing Android Studio + Android SDK Platform $TargetApi):" -ForegroundColor Cyan
    Write-Host "  flutter doctor -v"
    Write-Host "  flutter doctor --android-licenses"
    Write-Host "  flutter pub get"
    Write-Host "  flutter build apk --debug"
    Write-Host ""
    Write-Host "Do not create or commit the upload keystore yet. The release key must be stored safely and kept out of Git."
}
finally {
    Pop-Location
}
