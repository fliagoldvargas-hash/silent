Add-Type -AssemblyName System.Drawing

$outDir = Join-Path (Get-Location) "public\social"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$width = 1500
$height = 500
$bitmap = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bitmap)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$bg = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
  (New-Object System.Drawing.Rectangle(0, 0, $width, $height)),
  [System.Drawing.Color]::FromArgb(255, 0, 0, 0),
  [System.Drawing.Color]::FromArgb(255, 4, 4, 5),
  0
)
$g.FillRectangle($bg, 0, 0, $width, $height)
$bg.Dispose()

$vortexCenterX = 780
$vortexCenterY = 210
for ($i = 0; $i -lt 28; $i++) {
  $alpha = [Math]::Max(8, 80 - ($i * 2))
  $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb($alpha, 255, 35, 102), 1.1)
  $path = New-Object System.Drawing.Drawing2D.GraphicsPath
  $radius = 36 + ($i * 9)
  $path.AddArc($vortexCenterX - $radius, $vortexCenterY - ($radius * 0.55), $radius * 2, $radius * 1.1, 205, 284)
  $g.DrawPath($pen, $path)
  $path.Dispose()
  $pen.Dispose()
}

$dotBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(42, 255, 35, 102))
for ($x = 0; $x -lt $width; $x += 14) {
  for ($y = 0; $y -lt $height; $y += 14) {
    $dx = [Math]::Abs($x - $vortexCenterX) / 750
    $dy = [Math]::Abs($y - 270) / 270
    $edge = [Math]::Min(1.0, ($dx + $dy) / 1.35)
    $alpha = [int](34 * $edge)
    if ($alpha -gt 3) {
      $dotBrush.Color = [System.Drawing.Color]::FromArgb($alpha, 255, 35, 102)
      $g.FillEllipse($dotBrush, $x, $y, 2, 2)
    }
  }
}
$dotBrush.Dispose()

function Draw-Wisp {
  param(
    [System.Drawing.Graphics]$Graphics,
    [int]$StartX,
    [int]$StartY,
    [int]$Direction
  )
  for ($i = 0; $i -lt 9; $i++) {
    $pen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb((72 - $i * 5), 255, 35, 102), 1.4)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $y = $StartY + ($i * 18)
    $path.AddBezier($StartX, $y, $StartX + ($Direction * 210), $y - 110, $StartX + ($Direction * 360), $y + 95, $StartX + ($Direction * 580), $y - 10)
    $Graphics.DrawPath($pen, $path)
    $path.Dispose()
    $pen.Dispose()
  }
}

Draw-Wisp -Graphics $g -StartX -40 -StartY 42 -Direction 1
Draw-Wisp -Graphics $g -StartX 1540 -StartY 40 -Direction -1
Draw-Wisp -Graphics $g -StartX -80 -StartY 350 -Direction 1
Draw-Wisp -Graphics $g -StartX 1580 -StartY 330 -Direction -1

$shade = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(115, 0, 0, 0))
$g.FillRectangle($shade, 0, 0, $width, $height)
$shade.Dispose()

$text = "Trade privately. Win silently."
$fontSize = 82
do {
  $font = New-Object System.Drawing.Font("Arial", $fontSize, [System.Drawing.FontStyle]::Bold)
  $measure = $g.MeasureString($text, $font)
  if ($measure.Width -le ($width - 140) -or $fontSize -le 48) {
    break
  }
  $font.Dispose()
  $fontSize -= 2
} while ($true)
$format = New-Object System.Drawing.StringFormat
$format.Alignment = [System.Drawing.StringAlignment]::Center
$format.LineAlignment = [System.Drawing.StringAlignment]::Center
$format.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap
$rect = New-Object System.Drawing.RectangleF(70, 0, ($width - 140), $height)

$shadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(64, 255, 255, 255))
$shadowRect = New-Object System.Drawing.RectangleF(73, 3, ($width - 140), $height)
$g.DrawString($text, $font, $shadow, $shadowRect, $format)

$white = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(250, 250, 250))
$g.DrawString($text, $font, $white, $rect, $format)

$out = Join-Path $outDir "silent-twitter-banner-trade-privately.png"
$bitmap.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)

$font.Dispose()
$format.Dispose()
$shadow.Dispose()
$white.Dispose()
$g.Dispose()
$bitmap.Dispose()

Write-Output $out
