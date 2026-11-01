<#
--------------------------------------------------------------------------------
md_to_csv.ps1

Migration (Anf. 900): wandelt apex-new-features.md in eine CSV-Datei im
Importformat um (Anf. 440). Zusätzlich zu den Spalten aus Anf. 440 gibt es die
Spalte "release", weil die Quelle mehrere Releases enthält.

Quelle je Feature: Tabellenzeile unter einer Kategorie-Überschrift
   | [<Feature>](<Doku-Link>) | <Release> | <Zusammenfassung deutsch> |

Die Quelle hat keine englische Zusammenfassung und keine YouTube-Links, diese
Spalten bleiben leer (feat_summary_en wird beim Import zu 'empty').

Aufruf:
   powershell -File md_to_csv.ps1 [-Source ..\..\apex-new-features.md] [-Target nfo_features_migration.csv]
--------------------------------------------------------------------------------
#>
param (
   [string] $Source = (Join-Path $PSScriptRoot '..\..\apex-new-features.md'),
   [string] $Target = (Join-Path $PSScriptRoot 'nfo_features_migration.csv')
)

$ErrorActionPreference = 'Stop'

$categoryPattern = '^##\s+\S+\s+(.+?)\s*$'
$featurePattern  = '^\|\s\[(.*)\]\((https?://[^)]*)\)\s\|\s([0-9.]+)\s\|\s(.*)\s\|\s*$'

function Quote ([string] $value) {
   '"' + $value.Replace('"', '""') + '"'
}

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('Feature,release,feature_summary_de,feature_summary_en,category,link_feature_oracle_doc,link_feature_youtube')

$category = $null
$count    = 0
foreach ($line in [System.IO.File]::ReadAllLines((Resolve-Path $Source), [System.Text.Encoding]::UTF8)) {
   if ($line -match $categoryPattern) {
      $category = $Matches[1]
   }
   elseif ($line -match $featurePattern) {
      if (-not $category) { throw "Feature ohne Kategorie: $line" }
      $lines.Add((@(
         (Quote $Matches[1]), (Quote $Matches[3]), (Quote $Matches[4]), '""',
         (Quote $category), (Quote $Matches[2]), '""'
      ) -join ','))
      $count++
   }
}

[System.IO.File]::WriteAllLines($Target, $lines, [System.Text.UTF8Encoding]::new($false))
Write-Output "$count Features nach $Target geschrieben"
