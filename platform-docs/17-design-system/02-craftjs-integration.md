# 🎯 Craft.js Integration

## Overview

Craft.js is a React framework for building drag-and-drop page editors. It provides the foundation for the Template Editor's visual building experience.

## Core Concepts

### 1. Editor Component

```typescript
import { Editor, Frame, Element } from '@craftjs/core';

<Editor resolver={ComponentResolver}>
  <Frame>
    <Element canvas is="div" id="root">
      {/* Sections render here */}
    </Element>
  </Frame>
</Editor>
```

### 2. User Components

| Component | Purpose |
|-----------|---------|
| `Text` | Editable text content |
| `Image` | Image with upload |
| `Button` | Call-to-action button |
| `Container` | Layout wrapper |
| `Grid` | Responsive grid |

### 3. Component Resolver

Maps component types to actual React components.

```typescript
const ComponentResolver = {
  Text: CraftText,
  Image: CraftImage,
  Button: CraftButton,
  Hero: HeroSection,
  Products: ProductsGrid,
  // ... 50+ components
};
```

## Features

| Feature | Description |
|---------|-------------|
| **Drag & Drop** | Move components freely |
| **Inline Editing** | Edit content directly |
| **Layer Panel** | Component hierarchy |
| **History** | Undo/redo support |
| **Serialization** | Save/load JSON |

---

*Next: [Component Library](./03-component-library.md)*
