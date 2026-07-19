# Behaviors

## Global

- Smooth anchor navigation is enabled through CSS `scroll-behavior: smooth`.
- Sections animate into view with an IntersectionObserver. Initial state is opacity `0` and translateY `24px`; visible state is opacity `1` and translateY `0`.
- Header changes when `window.scrollY > 36`.

## Header

- Interaction model: scroll + hover + click.
- Scroll trigger: `window.scrollY > 36`.
- Before: full-width within 1280px container, min-height `78px`, square bottom.
- After: narrower container, min-height `62px`, rounded lower corners, deeper shadow.
- Hover: nav links change to pink; login border/background lifts subtly.
- Click: internal links scroll to sections; docs/login open external destinations.

## Hero

- Interaction model: time-driven visual animation + click CTA.
- Abstract smoke shapes float using a 9s ease-in-out keyframe loop.
- CTA hover lifts and increases pink glow.

## Problem

- Interaction model: reveal on scroll + time-driven visual pulse.
- Private/public trade cards are static content panels layered over a pulsing orbit.

## Technical Console

- Interaction model: click + search.
- Agent tabs update active state and change the console accent color.
- Search button hides agent tabs that do not match the typed query.

## Dashboard

- Interaction model: reveal on scroll + time-driven animation.
- Bars scale vertically in a staggered loop.

## Governance

- Interaction model: reveal on scroll + time-driven orbital animation.
- CTA scrolls back to the hero.
