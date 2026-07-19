# Documentation Page Specification

## Overview

- Target file: `documentation/index.html`
- Styles: `src/styles.css`
- Source URL: `https://www.excubialabs.com/documentation`
- Local route: `/documentation/`
- Interaction model: static content grid with hover/click states and reveal-on-scroll.

## Source Structure

- Minimal sticky topbar:
  - Back link
  - vertical divider
  - `docs` label
  - right-side globe/site icon
- Hero:
  - lightning mark plus brand label
  - `Documentation` heading
  - paragraph explaining protocol documentation
- Main content:
  - category heading `BASE`
  - two-column card grid
  - cards include category, title, truncated excerpt, date and arrow

## Adaptation

- `Excubia Labs` became `Silent Protocol`.
- `Shush Protocol™` became `Silent Protocol™`.
- Copy was adjusted so Silent Protocol is the only product/project identity.
- The local home `Docs` button now links to `documentation/`.

## Behaviors

- Back link navigates to the local home page.
- Documentation cards are informational blocks, not links or buttons.
- Card hover adds a subtle border/glow only to preserve the original visual feel without implying navigation.
- Sections reuse the global `.reveal` IntersectionObserver animation.

## Responsive Behavior

- Desktop: centered 1190px content area, two-column card grid.
- Tablet/mobile: one-column card grid below `820px`, tighter topbar padding.
