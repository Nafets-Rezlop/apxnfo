#-------------------------------------------------------------------------------
# Sprungmarken der Release-Videos aus apex-new-features.md (Abschnitt
# "Release Videos", Spalte "Chapters") nach nfo_video_chapters.sql (Anf. 220)
#
#   powershell -File md_chapters_to_sql.ps1
#
# Startsekunden und Video-ID stammen aus den Links https://youtu.be/<key>?t=<s>.
#-------------------------------------------------------------------------------

$ErrorActionPreference = 'Stop'

$mdFile  = Join-Path $PSScriptRoot '..\..\apex-new-features.md'
$sqlFile = Join-Path $PSScriptRoot 'nfo_video_chapters.sql'

$lines   = Get-Content -Path $mdFile -Encoding UTF8
$inTable = $false
$calls   = New-Object System.Collections.Generic.List[string]
$seen    = @{}

foreach ($line in $lines) {
   if ($line -match '^## .*Release Videos') { $inTable = $true; continue }
   if ($inTable -and $line -match '^## ') { break }
   if (-not $inTable -or $line -notmatch '^\| [0-9]') { continue }

   $cells = $line.Split('|')
   $chapterCell = $cells[3].Trim()
   if ($chapterCell -eq '-') { continue }

   foreach ($part in ($chapterCell -split '<br>')) {
      if ($part -notmatch '^\s*\[[0-9:]+\]\(https://youtu\.be/([A-Za-z0-9_-]{11})\?t=([0-9]+)\)\s*(.*)$') {
         throw "Sprungmarke nicht erkannt: $part"
      }
      $key   = $Matches[1]
      $secs  = [int]$Matches[2]
      $title = ($Matches[3] -replace '^[\s\-]+', '' -replace '\s+', ' ').Trim()
      if ($title.Contains(']''')) { throw "Titel nicht als q'[...]' darstellbar: $title" }

      $url = "${key}?t=${secs}"
      if ($seen.ContainsKey($url)) { continue }
      $seen[$url] = $true

      $calls.Add("   mrg_chapter('$key', $secs, q'[$title]');")
   }
}

$header = @'
--------------------------------------------------------------------------------
-- Sprungmarken der Release-Videos (Anf. 220)
--
-- GENERIERT von md_chapters_to_sql.ps1 aus apex-new-features.md, nicht von
-- Hand aendern. Wiederholbar: vorhandene Sprungmarken (Link) werden
-- aktualisiert.
-- Voraussetzung: Videos sind geladen (nfo_release_videos.sql).
--------------------------------------------------------------------------------

whenever sqlerror exit failure
set define off
set serveroutput on size unlimited

-- ADB (Service HIGH): sonst ORA-12839 bei mehreren DML in einer Transaktion
alter session disable parallel dml;

declare
   procedure mrg_chapter (p_key in varchar2, p_seconds in number, p_title in varchar2) is
      l_rec v_nfo_ui_video_chapters%rowtype;
      l_md5 varchar2(32767);
   begin
      l_rec.chap_link_url := 'https://youtu.be/' || p_key || '?t=' || p_seconds;
      begin
         select chap_id into l_rec.chap_id from t_nfo_video_chapters where chap_link_url = l_rec.chap_link_url;
         pkg_nfo_chap_dml.get(l_rec, l_md5);
      exception
         when no_data_found then
            null;
      end;
      select vid_id into l_rec.chap_vid_id from t_nfo_release_videos where vid_youtube_key = p_key;
      l_rec.chap_start_seconds := p_seconds;
      l_rec.chap_title         := p_title;
      pkg_nfo_chap_dml.mrg(l_rec, l_md5);
   exception
      when no_data_found then
         raise_application_error(-20100, 'Video ' || p_key || ' fehlt fuer Sprungmarke ' || p_seconds);
   end mrg_chapter;
begin
'@

$footer = @'
end;
/

commit;

select v.rel_version, v.vid_youtube_key, count(c.chap_id) as chapters
  from v_nfo_ui_release_videos v
  left join v_nfo_ui_video_chapters c
    on c.chap_vid_id = v.vid_id
 group by v.rel_version, v.vid_youtube_key
 order by v.rel_version desc, v.vid_youtube_key;
'@

$text = $header + "`n" + ($calls -join "`n") + "`n" + $footer + "`n"
$text = $text -replace "`r`n", "`n"
[IO.File]::WriteAllText($sqlFile, $text, (New-Object System.Text.UTF8Encoding $false))
Write-Host "$($calls.Count) Sprungmarken nach $sqlFile geschrieben"
