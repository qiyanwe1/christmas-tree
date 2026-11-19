# 等待录制完成 → ffmpeg 转高画质 mp4
$log = "$PSScriptRoot\build-video.log"
function Log($m) { "$([DateTime]::Now.ToString('HH:mm:ss')) $m" | Out-File $log -Append -Encoding utf8 }

Log '等待录制脚本输出 DONE...'
$deadline = (Get-Date).AddMinutes(4)
while ((Get-Date) -lt $deadline) {
  if ((Get-Content "$PSScriptRoot\rec.out" -ErrorAction SilentlyContinue) -match 'DONE') { break }
  Start-Sleep -Seconds 5
}
$webm = Get-ChildItem "$PSScriptRoot\out" -Filter '*.webm' | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if (-not $webm) { Log '无 webm 产物，失败'; exit 1 }
Log ('录制完成: ' + $webm.FullName + ' ' + [math]::Round($webm.Length/1MB,1) + 'MB')

Log 'ffmpeg 转码 (H.264 CRF14 slow)...'
$mp4 = "$PSScriptRoot\..\christmas-4k.mp4"
ffmpeg -y -i $webm.FullName -c:v libx264 -crf 14 -preset slow -pix_fmt yuv420p -movflags +faststart $mp4 2>&1 | Select-Object -Last 2 | Out-String | ForEach-Object { Log $_ }
if (Test-Path $mp4) { Log ('完成: ' + $mp4 + ' ' + [math]::Round((Get-Item $mp4).Length/1MB,1) + 'MB') } else { Log '转码失败' }
