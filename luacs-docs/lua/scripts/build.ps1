Import-Module $PSScriptRoot/../../scripts/location.ps1

try {
  cd $PSScriptRoot/..

  Remove-Item -Force -Recurse ./build | Out-Null
  New-Item -ItemType Directory ./build | Out-Null
  Copy-Item -Path ./css/. -Destination ./build -Recurse -Force | Out-Null
  Copy-Item -Path ./js/. -Destination ./build -Recurse -Force | Out-Null

  if ((Get-Command "lua_modules/bin/ldoc" -ErrorAction SilentlyContinue) -eq $null) {
    echo "ldoc not found; please run docs/scripts/install.ps1"
    exit 1
  }

  lua_modules/bin/ldoc .
} finally {
  Restore-Location
}
