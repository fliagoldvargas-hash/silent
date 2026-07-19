# Site Specification

## Overview

- Target files: `index.html`, `src/styles.css`, `src/main.js`
- Interaction model: scroll-driven, click-driven, hover, and time-driven animation
- Source: `https://excubiaprotocol.com/`

## DOM Structure

- `header.site-header`
  - logo mark
  - centered nav
  - login link
- `main`
  - `section.hero`
  - `section.feature-strip`
  - `section.problem`
  - `section.technical`
  - `section.dashboard`
  - `section.governance`
- `footer`
  - brand block
  - three link groups
  - status link

## Visual Styles

- Background: nearly black `#020202`
- Text: off-white `#f5f3f1`
- Muted text: `#a4a0a0`
- Borders: low opacity white `rgba(255, 255, 255, 0.08)`
- Primary accent: hot pink `#ff2366`
- Secondary accent: soft pink `#ff6a9a`
- Main typography: system sans stack
- Label typography: monospace for source-like bracket labels
- Border radius: mostly 8px to 18px, matching the compact technical product look

## Text Content

All product naming is normalized to Silent Protocol:

- `INTRODUCING SILENT PROTOCOL™`
- `The market sees everything. We built the blind spot.`
- `Your strategy never surfaces. Your alpha never leaks. Trade in a whisper. Win in silence.`
- `Silent Protocol™ changes the rules of the game.`
- `Strategy encrypted via Silent Protocol™. Silent Agent executes quietly. Bots see only noise.`
- `One protocol. One product. Private execution for invisible strategy.`

## States & Behaviors

- Header compact state after 36px scroll.
- Section reveal animations via IntersectionObserver.
- Hero smoke animation loops with CSS keyframes.
- Agent console tab active state and accent color changes.
- Agent search filters visible tab buttons.
- Dashboard bars animate continuously.
- Governance orbital points animate continuously.

## Responsive Behavior

- Desktop: header/nav centered, hero large typography, two-column technical/problem/dashboard layouts.
- Tablet: content stacks to one column at `820px`.
- Mobile: header compresses, nav scrolls horizontally, CTA becomes full width, code text scales smaller.
