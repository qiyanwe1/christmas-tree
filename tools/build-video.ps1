# 录制并转码流水线：等 chromium 就绪 → 4K 录制 30s → ffmpeg 转高画质 mp4
$ErrorActionPreference = 'Stop'
$log = "$PSScriptRoot\build-video.log"
function Log($m) { "$([DateTime]::Now.ToString('HH:mm:ss')) $m" | Tee-Object -FilePath $log -Append }

Log '等待 chromium 内核下载完成...'
$deadline = (Get-Date).AddMinutes(20)
$ready = $false
while ((Get-Date) -lt $deadline) {
  $d = Get-ChildItem "$env:LOCALAPPDATA\ms-playwright" -Directory -Filter 'chromium-*' -ErrorAction SilentlyContinue
  if ($d) { $ready = $true; break }
  Start-Sleep -Seconds 10
}
if (-not $ready) { Log '超时：chromium 未就绪'; exit 1 }
Log ('chromium 就绪: ' + $d.Name)

Log '开始 4K 录制 30 秒...'
Push-Location "$PSScriptRoot\..\tools"
node record.mjs 30 2>&1 | Out-String | ForEach-Object { Log $_ }
Pop-Location

$webm = Get-ChildItem "$PSScriptRoot\..\tools\out" -Filter '*.webm' | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $webm) { Log '未找到录制的 webm'; exit 1 }
Log ('录制完成: ' + $webm.FullName)

Log 'ffmpeg 转码为高画质 mp4 (H.264, CRF 14, slow)...'
$mp4 = "$PSScriptRoot\..\christmas-4k.mp4"
ffmpeg -y -i $webm.FullName -c:v libx264 -crf 14 -preset slow -pix_fmt yuv420p -movflags +faststart $mp4 2>&1 | Out-String | ForEach-Object { Log $_ }
Log ('完成: ' + $mp4)
