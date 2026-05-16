# Bootstrap NotebookLM "Kling 3.0 Production Reference"
# Run AFTER: nlm login (interactive browser auth)
#
# Creates a NotebookLM notebook seeded with:
#   - The synthesized 08-kling-production-guide.md as pasted-text source
#   - 10 source URLs from WebSearch research (official + community guides)
# Output: notebook ID + alias `kling-prod` for future ops
#
# Usage: pwsh -File scripts/bootstrap-kling-notebooklm.ps1

$ErrorActionPreference = "Stop"
$env:PYTHONIOENCODING = "utf-8"

Write-Host "==> Verifying auth..." -ForegroundColor Cyan
$authCheck = nlm notebook list --quiet 2>&1
if ($authCheck -match "Authentication") {
    Write-Host "  ERR: Run 'nlm login' first." -ForegroundColor Red
    exit 1
}

Write-Host "==> Creating notebook 'Kling 3.0 Production Reference'..." -ForegroundColor Cyan
$createOutput = nlm notebook create "Kling 3.0 Production Reference" 2>&1
$nbId = ($createOutput | Select-String -Pattern '[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}').Matches.Value | Select-Object -First 1

if (-not $nbId) {
    Write-Host "  ERR: Could not extract notebook ID. Raw output:" -ForegroundColor Red
    Write-Host $createOutput
    exit 1
}

Write-Host "  Notebook ID: $nbId" -ForegroundColor Green

Write-Host "==> Setting alias 'kling-prod'..." -ForegroundColor Cyan
nlm alias set kling-prod $nbId | Out-Null

Write-Host "==> Adding synthesized guide as text source..." -ForegroundColor Cyan
$guidePath = Join-Path $PSScriptRoot "..\reference\image-video-gen\08-kling-production-guide.md"
$guideContent = Get-Content $guidePath -Raw
nlm source add kling-prod --text $guideContent --title "Kling 3.0 Synthesized Production Guide (v1.0, 2026-05-16)"
Start-Sleep -Seconds 2

Write-Host "==> Adding 10 source URLs..." -ForegroundColor Cyan
$urls = @(
    "https://app.klingai.com/global/quickstart/motion-control-user-guide",
    "https://kling.ai/blog/kling-video-3-omni-native-lip-sync-audio-guide",
    "https://blog.fal.ai/kling-3-0-prompting-guide/",
    "https://invideo.io/blog/kling-3-0-complete-guide/",
    "https://wavespeed.ai/blog/posts/seedance-2-0-vs-kling-3-0-sora-2-veo-3-1-video-generation-comparison-2026/",
    "https://www.atlabs.ai/blog/kling-3-0-prompting-guide-master-ai-video-generation",
    "https://www.veed.io/ai-models/video/kling-3-0",
    "https://videoai.me/blog/kling-ai-prompt-mistakes",
    "https://magichour.ai/blog/kling-30-vs-veo-31",
    "https://vicsee.com/blog/kling-3-prompts"
)

$added = 0
foreach ($url in $urls) {
    Write-Host "  [+] $url" -ForegroundColor DarkGray
    try {
        nlm source add kling-prod --url $url 2>&1 | Out-Null
        $added++
        Start-Sleep -Seconds 2
    } catch {
        Write-Host "  WARN: failed $url ($_)" -ForegroundColor Yellow
    }
}

Write-Host "==> Verifying sources..." -ForegroundColor Cyan
nlm source list kling-prod

Write-Host ""
Write-Host "==> DONE." -ForegroundColor Green
Write-Host "    Notebook ID : $nbId" -ForegroundColor Green
Write-Host "    Alias       : kling-prod" -ForegroundColor Green
Write-Host "    Sources     : $($added + 1) (1 text + $added URLs)" -ForegroundColor Green
Write-Host ""
Write-Host "==> Next steps:" -ForegroundColor Cyan
Write-Host "    nlm notebook describe kling-prod       # AI-generated summary"
Write-Host "    nlm report create kling-prod --format `"Briefing Doc`" --confirm"
Write-Host "    nlm audio create kling-prod --format deep_dive --confirm"
Write-Host "    nlm notebook query kling-prod `"What's the canonical Kling 3.0 prompt formula?`""
