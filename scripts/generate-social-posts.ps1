Add-Type -AssemblyName System.Drawing

$outDir = Join-Path (Get-Location) "public\social"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$templatePath = Join-Path $outDir "silent-x-template-reference.png"
if (-not (Test-Path $templatePath)) {
  throw "Missing template reference image: $templatePath"
}

$posts = @(
  @{
    Slug = "01-market-sees-everything"
    Title = "The market sees everything."
    Subtitle = "Silent Protocol makes your strategy invisible."
  },
  @{
    Slug = "02-alpha-should-not-leak"
    Title = "Your alpha should not leak."
    Subtitle = "Encrypt the strategy. Execute in silence."
  },
  @{
    Slug = "03-private-agents-public-markets"
    Title = "Private agents. Public markets."
    Subtitle = "Trade without broadcasting your intent."
  },
  @{
    Slug = "04-noise-for-bots"
    Title = "Bots read signals. Give them noise."
    Subtitle = "Hide intent before it becomes someone else's edge."
  },
  @{
    Slug = "05-keys-stay-yours"
    Title = "Your keys stay yours."
    Subtitle = "User-owned privacy for encrypted agents."
  },
  @{
    Slug = "06-strategy-stays-sealed"
    Title = "Strategy stays sealed."
    Subtitle = "Agents execute without exposing the playbook."
  },
  @{
    Slug = "07-built-for-blind-spot"
    Title = "Built for the blind spot."
    Subtitle = "Where public markets stop seeing your edge."
  },
  @{
    Slug = "08-trade-in-whisper"
    Title = "Trade in a whisper."
    Subtitle = "Silent execution for strategies that cannot surface."
  },
  @{
    Slug = "09-invisible-by-design"
    Title = "Invisible by design."
    Subtitle = "Privacy is not a feature. It is the protocol."
  },
  @{
    Slug = "10-one-protocol-private-edge"
    Title = "One protocol. Private edge."
    Subtitle = "Encrypted execution. Private strategy. User ownership."
  }
)

function New-FitFont {
  param(
    [System.Drawing.Graphics]$Graphics,
    [string]$Text,
    [string]$Family,
    [int]$StartSize,
    [int]$MinSize,
    [int]$MaxWidth,
    [System.Drawing.FontStyle]$Style
  )

  $size = $StartSize
  do {
    $font = New-Object System.Drawing.Font($Family, $size, $Style)
    $measured = $Graphics.MeasureString($Text, $font)
    if ($measured.Width -le $MaxWidth -or $size -le $MinSize) {
      return $font
    }
    $font.Dispose()
    $size -= 2
  } while ($true)
}

function Draw-CenteredText {
  param(
    [System.Drawing.Graphics]$Graphics,
    [string]$Text,
    [System.Drawing.Font]$Font,
    [System.Drawing.Brush]$Brush,
    [int]$Y,
    [int]$Width,
    [int]$Height
  )

  $format = New-Object System.Drawing.StringFormat
  $format.Alignment = [System.Drawing.StringAlignment]::Center
  $format.LineAlignment = [System.Drawing.StringAlignment]::Near
  $format.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap
  $rect = New-Object System.Drawing.RectangleF(90, $Y, ($Width - 180), $Height)
  $Graphics.DrawString($Text, $Font, $Brush, $rect, $format)
  $format.Dispose()
}

$template = [System.Drawing.Image]::FromFile($templatePath)

foreach ($post in $posts) {
  $width = $template.Width
  $height = $template.Height
  $bitmap = New-Object System.Drawing.Bitmap($width, $height)
  $g = [System.Drawing.Graphics]::FromImage($bitmap)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

  $g.DrawImage($template, 0, 0, $width, $height)

  $cover = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 0, 0, 0))
  $g.FillRectangle($cover, 0, 396, $width, 280)
  $cover.Dispose()

  $fadeTop = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(0, 356, $width, 64)),
    [System.Drawing.Color]::FromArgb(0, 0, 0, 0),
    [System.Drawing.Color]::FromArgb(255, 0, 0, 0),
    90
  )
  $g.FillRectangle($fadeTop, 0, 356, $width, 64)
  $fadeTop.Dispose()

  $fadeBottom = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Rectangle(0, 656, $width, 74)),
    [System.Drawing.Color]::FromArgb(255, 0, 0, 0),
    [System.Drawing.Color]::FromArgb(0, 0, 0, 0),
    90
  )
  $g.FillRectangle($fadeBottom, 0, 656, $width, 74)
  $fadeBottom.Dispose()

  $dotBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(24, 255, 35, 102))
  for ($x = 0; $x -lt $width; $x += 17) {
    for ($y = 430; $y -lt 680; $y += 17) {
      $centerFade = [Math]::Min(1.0, [Math]::Abs($x - ($width / 2)) / 720.0)
      $alpha = [int](25 * $centerFade)
      if ($alpha -gt 3) {
        $dotBrush.Color = [System.Drawing.Color]::FromArgb($alpha, 255, 35, 102)
        $g.FillEllipse($dotBrush, $x, $y, 2, 2)
      }
    }
  }
  $dotBrush.Dispose()

  $titleFont = New-FitFont -Graphics $g -Text $post.Title -Family "Arial" -StartSize 100 -MinSize 64 -MaxWidth ($width - 220) -Style ([System.Drawing.FontStyle]::Bold)
  $subtitleFont = New-FitFont -Graphics $g -Text $post.Subtitle -Family "Arial" -StartSize 48 -MinSize 34 -MaxWidth ($width - 300) -Style ([System.Drawing.FontStyle]::Bold)

  $titleShadow = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(76, 255, 255, 255))
  $titleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(246, 246, 246))
  $subtitleBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(166, 166, 166))

  Draw-CenteredText -Graphics $g -Text $post.Title -Font $titleFont -Brush $titleShadow -Y 439 -Width $width -Height 118
  Draw-CenteredText -Graphics $g -Text $post.Title -Font $titleFont -Brush $titleBrush -Y 432 -Width $width -Height 118
  Draw-CenteredText -Graphics $g -Text $post.Subtitle -Font $subtitleFont -Brush $subtitleBrush -Y 564 -Width $width -Height 72

  $out = Join-Path $outDir ("silent-x-" + $post.Slug + ".png")
  $bitmap.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)

  $titleFont.Dispose()
  $subtitleFont.Dispose()
  $titleShadow.Dispose()
  $titleBrush.Dispose()
  $subtitleBrush.Dispose()
  $g.Dispose()
  $bitmap.Dispose()
}

$template.Dispose()
Write-Output "Generated $($posts.Count) social images in $outDir"
