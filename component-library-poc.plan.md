# Framework-Agnostic Component Library POC

## Architecture Overview

Create a monorepo structure with:

- **Core package** (`@odonata/components`): Lit-based Web Components with Tailwind
- **React wrapper** (`@odonata/components-react`): React bindings
- **Vue wrapper** (`@odonata/components-vue`): Vue bindings  
- **React Native wrapper** (`@odonata/components-react-native`): React Native bindings
- **Storybook**: Shared documentation and development environment
- **Single-spa config**: Example micro-frontend setup

## Implementation Steps

### 1. Monorepo Setup

Create a `packages/` directory at the root level alongside the Rails app:

```
OdonataOverture/
├── app/ (Rails)
├── packages/
│   ├── components/ (Lit Web Components)
│   ├── components-react/ (React wrappers)
│   ├── components-vue/ (Vue wrappers)
│   ├── components-react-native/ (React Native wrappers)
│   ├── tokens/ (Shared design tokens)
│   ├── storybook/ (Shared Storybook)
│   └── single-spa-example/ (POC micro-frontend)
├── package.json (workspace root)
└── turbo.json (Turborepo for builds)
```

**Tools:**

- **pnpm workspaces**: Fast, efficient package manager for monorepos
- **Turborepo**: Build orchestration and caching (speed for small teams)
- **Vite**: Fast dev server and bundling
- **TypeScript**: Type safety across all packages

### 2. Core Components Package

**`packages/components/`** - Lit Web Components with Tailwind

Key files:

- `src/components/button/button.ts`: Example Lit component
- `src/index.ts`: Barrel export
- `tailwind.config.js`: Shared design tokens
- `vite.config.ts`: Build configuration
- `package.json`: Exports for ESM/CJS

**Inspiration from shadcn approach:**

- Composable primitives (Button, Input, Card, etc.)
- Accessible by default (ARIA attributes)
- Customizable via CSS custom properties
- Copy-paste friendly (consumers can eject and customize)

**Design tokens structure:**

```typescript
// Match Carbon/shadcn patterns
colors: { primary, secondary, accent, destructive, muted }
spacing: { xs, sm, md, lg, xl }
typography: { size, weight, line-height }
```

### 3. Framework Wrappers

**React wrapper** (`packages/components-react/`):

- Use `@lit/react` for automatic event binding
- TypeScript definitions for props
- Tree-shakeable exports

**Vue wrapper** (`packages/components-vue/`):

- Vue 3 composition API wrappers
- Proper v-model bindings
- TypeScript support

**React Native wrapper** (`packages/components-react-native/`):

- Separate implementation using React Native primitives
- Shared design tokens (colors, spacing, typography)
- Shared TypeScript interfaces for props
- Similar component API to web version

Both web wrappers are thin layers that:

1. Import the Web Component
2. Provide framework-specific ergonomics
3. Re-export with proper types

The React Native wrapper:

1. Cannot use Web Components (no DOM in React Native)
2. Reimplements components using `View`, `Text`, `Pressable`, etc.
3. Shares design system values via shared token package
4. Maintains API parity where possible

### 4. Storybook Configuration

**`packages/storybook/`** - Version 8.x

Features:

- **Web Components support** via `@storybook/web-components`
- **Multiple framework stories**: Show same component in React/Vue/vanilla contexts
- **Docs addon**: Auto-generated documentation
- **Accessibility addon**: a11y testing
- **Controls addon**: Interactive prop editing
- **Design tokens page**: Visual style guide

Stories structure:

```
stories/
├── Button.stories.ts (Web Component)
├── Button.react.stories.tsx (React usage)
└── Button.vue.stories.ts (Vue usage)
```

### 5. Single-spa Integration Example

**`packages/single-spa-example/`** - Proof of concept

- **Root config**: Orchestrator application
- **React microfrontend**: Uses `@odonata/components-react`
- **Vue microfrontend**: Uses `@odonata/components-vue`
- **Shared navigation**: Web Components in shell

Demonstrates:

- Component library usage across frameworks
- Style encapsulation (no conflicts)
- Shared design system
- Module loading strategies

### 6. Build & Publishing Setup

**Package publishing strategy:**

- Private npm registry or GitHub Packages (for POC)
- Versioning with Changesets (automated changelog)
- CI/CD with GitHub Actions (build, test, publish)

**Build outputs:**

- ESM and CJS for Node.js compatibility
- UMD for CDN usage
- TypeScript declarations
- Source maps

### 7. Documentation & DX

Create comprehensive docs:

- **README.md**: Quick start guide
- **CONTRIBUTING.md**: Component development guide
- **Architecture Decision Records**: Why Web Components, why Lit, etc.
- **Migration guide**: How to adopt in existing projects

Developer tools:

- ESLint + Prettier (consistent code style)
- Husky + lint-staged (pre-commit checks)
- Vitest (fast unit testing)
- Playwright (E2E testing for critical flows)

## POC Scope (Initial Components)

Start with 5 essential components to prove the architecture:

1. **Button**: Primary, secondary, destructive variants
2. **Input**: Text input with validation states
3. **Card**: Container with header/body/footer slots
4. **Icon**: SVG icon system
5. **Toast**: Notification component (tests event handling)

Each component includes:

- Lit implementation with Shadow DOM
- Tailwind styling via CSS custom properties
- React wrapper
- Vue wrapper
- React Native wrapper
- Storybook stories (all contexts)
- Unit tests
- Accessibility tests

## Success Criteria

- ✅ Components work identically in React, Vue, React Native, and vanilla JS
- ✅ No style conflicts when multiple frameworks coexist
- ✅ Build time < 10s for full monorepo
- ✅ Components are accessible (WCAG AA)
- ✅ TypeScript autocomplete works in all contexts
- ✅ Storybook builds and deploys
- ✅ Single-spa example runs locally

## Timeline Estimate

For a small team (1-2 developers):

- **Week 1**: Monorepo setup, tooling, first component (Button)
- **Week 2**: 4 more components, wrappers, tests
- **Week 3**: Storybook polish, single-spa example, documentation
- **Week 4**: Refinement, stakeholder demo, feedback iteration

## Longevity Considerations

- **Web Components**: W3C standard, native browser support, future-proof
- **Lit**: Google-backed, mature, small runtime (~5KB)
- **Tailwind**: Industry standard, massive ecosystem
- **Storybook**: Industry standard for component libraries
- **TypeScript**: Longevity through maintainability
- **Testing**: Vitest (fast) + Playwright (reliable E2E)

## Alternative Considered (For Context)

**If speed was the ONLY factor**: Use Mitosis or just build separate React/Vue implementations. However, Web Components + Lit provides the best balance of speed (mature tooling), longevity (web standards), and team size (less code to maintain).

## Resources & References

### Core Technologies

- **Lit**: https://lit.dev/ - Official documentation for Web Components library
- **Lit Design Patterns**: https://lit.dev/docs/composition/component-composition/ - Component composition guide
- **@lit/react**: https://lit.dev/docs/frameworks/react/ - Official React wrapper utilities
- **Web Components Best Practices**: https://web.dev/articles/custom-elements-best-practices - Google's web.dev guide

### Design System Inspiration

- **shadcn/ui**: https://ui.shadcn.com/ - For component API design patterns and Tailwind approach
- **Carbon Design System**: https://carbondesignsystem.com/ - For accessibility patterns and token structure
- **Shoelace**: https://shoelace.style/ - Mature Web Components library with excellent patterns

### Monorepo & Tooling

- **Turborepo**: https://turbo.build/repo/docs - Monorepo build orchestration
- **pnpm Workspaces**: https://pnpm.io/workspaces - Efficient package management
- **Vite Library Mode**: https://vitejs.dev/guide/build.html#library-mode - Fast bundling for libraries
- **Changesets**: https://github.com/changesets/changesets - Version management and changelogs

### Storybook

- **Storybook for Web Components**: https://storybook.js.org/docs/web-components/get-started/introduction
- **Storybook Composition**: https://storybook.js.org/docs/sharing/storybook-composition - For multi-framework stories
- **Accessibility Testing**: https://storybook.js.org/addons/@storybook/addon-a11y

### Micro-Frontend Architecture

- **single-spa**: https://single-spa.js.org/ - Framework for micro-frontends
- **single-spa with Web Components**: https://single-spa.js.org/docs/ecosystem-web-components - Integration guide
- **Micro-Frontends.org**: https://micro-frontends.org/ - Architectural patterns and trade-offs

### Styling & Design Tokens

- **Tailwind in Shadow DOM**: https://tailwindcss.com/docs/reusing-styles - Strategies for component styling
- **Open Props**: https://open-props.style/ - Alternative approach to design tokens with CSS custom properties
- **CSS Custom Properties Guide**: https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties

### Testing

- **Vitest**: https://vitest.dev/ - Fast unit testing framework
- **@open-wc/testing**: https://open-wc.org/docs/testing/testing-package/ - Web Components testing utilities
- **Playwright**: https://playwright.dev/ - E2E testing for component interactions

### TypeScript

- **TypeScript for Web Components**: https://lit.dev/docs/components/properties/#types - Type-safe Lit components
- **@custom-elements-manifest/analyzer**: https://custom-elements-manifest.open-wc.org/ - Auto-generate docs from TS

### Alternative Approaches Researched

- **Mitosis**: https://github.com/BuilderIO/mitosis - Write once, compile to any framework (newer, less mature)
- **Stencil**: https://stenciljs.com/ - Alternative Web Components compiler (more opinionated than Lit)
- **Module Federation**: https://webpack.js.org/concepts/module-federation/ - Alternative micro-frontend approach

### Case Studies

- **Adobe Spectrum Web Components**: https://opensource.adobe.com/spectrum-web-components/ - Enterprise example
- **ING Lion**: https://lion-web.netlify.app/ - Banking industry Web Components library
- **Vaadin Components**: https://vaadin.com/docs/latest/components - Commercial example with React/Vue wrappers

## Implementation Progress

### Completed Tasks
- [x] Create component library POC plan document
- [x] Set up monorepo workspace structure

### In Progress
- [ ] Initialize pnpm workspace, Turborepo, and base package structure
- [ ] Set up @odonata/components with Lit, Vite, Tailwind, and TypeScript
- [ ] Create Button component as template (Lit + styles + tests)
- [ ] Configure Storybook with web-components, a11y, and docs addons
- [ ] Create React and Vue wrapper packages with Button example
- [ ] Implement Input, Card, Icon, and Toast components with wrappers
- [ ] Build single-spa POC with React and Vue microfrontends
- [ ] Write README, architecture docs, and component usage guides

## Next Steps

1. Initialize monorepo with pnpm + Turborepo
2. Set up core components package with Lit + Vite + Tailwind
3. Create Button component as template
4. Set up Storybook
5. Create React/Vue/React Native wrappers for Button
6. Replicate for remaining 4 components
7. Build single-spa example
8. Document and demo
