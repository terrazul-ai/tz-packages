# Impeccable Style

A comprehensive design system for creating distinctive, production-grade frontend interfaces. This package provides commands and guidelines to help you avoid generic AI-generated patterns ("AI slop") and create intentional, polished designs.

## Philosophy

- **Context First**: Always gather proper context before design work (target audience, brand personality, use cases)
- **Anti-AI-Slop**: Avoid generic patterns like cyan/purple gradients, gratuitous glassmorphism, bounce animations, and neon accents
- **Production-Ready**: Focus on real-world scenarios, accessibility, internationalization, and edge cases
- **Intentionality Over Trends**: Choose a clear aesthetic direction and execute with precision

## Available Commands

### Design Adjustments
- `/bolder` - Amplify visual impact of safe or boring designs
- `/quieter` - Tone down overly bold or aggressive designs
- `/simplify` - Strip designs to their essence, remove complexity
- `/colorize` - Strategically introduce color to monochromatic designs

### Quality & Polish
- `/audit` - Comprehensive interface audit (accessibility, performance, theming)
- `/critique` - Holistic design critique with prioritized feedback
- `/polish` - Final quality pass for pixel-perfect results
- `/normalize` - Align designs with established design system standards

### Content & Copy
- `/clarify` - Improve unclear interface text and error messages
- `/delight` - Add moments of joy and personality without blocking usability

### Production Hardening
- `/harden` - Strengthen interfaces against edge cases, errors, i18n issues
- `/optimize` - Identify and fix performance issues
- `/adapt` - Adapt designs for different screen sizes and contexts

### Motion & Interaction
- `/animate` - Add purposeful animations and micro-interactions

### System Building
- `/extract` - Identify and extract reusable patterns into design system
- `/onboard` - Design onboarding experiences and empty states

### Setup
- `/teach-impeccable` - One-time setup to gather design context for your project

## Frontend Design Skill

The `frontend-design` skill provides comprehensive guidelines for creating distinctive interfaces. It includes reference materials on:

- **Typography** - Modular scales, font selection, web font loading
- **Color & Contrast** - OKLCH color spaces, functional palettes, theming
- **Spatial Design** - 4pt spacing system, grids, visual hierarchy
- **Motion Design** - Duration, easing, GPU acceleration, reduced motion
- **Interaction Design** - Interactive states, focus management, forms
- **Responsive Design** - Mobile-first, container queries, input detection
- **UX Writing** - Button labels, error messages, voice and tone

## The AI Slop Test

Before shipping any design, verify it doesn't exhibit these generic AI patterns:

- Cyan/purple gradients everywhere
- Glassmorphism without purpose
- Generic card layouts
- Bounce/elastic easing on everything
- Rounded rectangles with colored borders
- Neon accents on dark backgrounds
- Gradient text on metrics

## Usage

Invoke commands with the `/` prefix (e.g., `/audit`, `/polish`). The frontend-design skill is automatically available when working on UI code.
