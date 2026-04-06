# 🧩 Template Editor Components

## Component Hierarchy

### 1. TemplateEditor.tsx (Main Component)

**Props**:
| Prop | Type | Description |
|------|------|-------------|
| `storeId` | `string` | Store identifier |
| `templateId` | `string` | Optional template ID |
| `sellerId` | `string` | Seller identifier |
| `defaultValues` | `TemplateFormData` | Initial template data |
| `locale` | `string` | Language locale |
| `onChange` | `(data) => void` | Change callback |
| `onTabChange` | `(tabId) => void` | Tab change callback |

**State Variables**:
| State | Type | Purpose |
|-------|------|---------|
| `sections` | `Section[]` | Page sections array |
| `templateName` | `string` | Template name |
| `theme` | `'light'\|'dark'\|'custom'` | Theme selection |
| `font` | `string` | Font family |
| `colors` | `ColorPalette` | Color configuration |
| `components` | `string[]` | Custom components |
| `testimonials` | `Testimonial[]` | Testimonials data |
| `backgroundImage` | `string` | Background image URL |
| `heroConfig` | `HeroConfig` | Hero section config |
| `isPublic` | `boolean` | Public visibility |
| `isDeveloperMode` | `boolean` | Developer mode toggle |
| `customCode` | `Record<string, string>` | Custom HTML/CSS/JS |

### 2. Tabs Configuration

| Tab ID | Label | Icon | Description |
|--------|-------|------|-------------|
| `general` | General | Settings | Basic template info, colors, fonts |
| `sections` | Sections | Layout | Drag & drop sections management |
| `appearance` | Appearance | Palette | Hero, components, testimonials |
| `content` | Content | FileText | Content statistics and summary |
| `developer` | Developer | Code | Custom HTML/CSS/JS editor |
| `preview` | Preview | Eye | Live preview with responsive modes |

### 3. Quick Stats Cards

| Stat | Icon | Color | Source |
|------|------|-------|--------|
| Sections | Layout | Blue | `sections.length` |
| Components | Package | Green | `components.length` |
| Testimonials | Star | Yellow | `testimonials.length` |
| Status | Eye/EyeOff | Emerald/Gray | `isPublic` |

### 4. Section Types with Icons

| Section Type | Icon Component | Category |
|--------------|----------------|----------|
| text | FileText | Basic |
| image | Image | Basic |
| video | VideoIcon | Basic |
| button | MousePointer2 | Basic |
| heading | HeadingIcon | Basic |
| divider | Minus | Basic |
| spacer | GripVertical | Basic |
| columns | ColumnsIcon | Layout |
| sidebar | Layout | Layout |
| carousel | Images | Media |
| slider | Images | Media |
| gallery | Images | Media |
| pricing-table | DollarSign | Content |
| cta | Megaphone | Content |
| accordion | ListChecks | Content |
| tabs | Layout | Content |
| testimonials | Star | Content |
| faq | HelpCircle | Content |
| products | ShoppingBag | E-commerce |
| product-card | Package | E-commerce |
| collection-banner | Image | E-commerce |
| upsell | ShoppingBag | E-commerce |
| hero | Sparkles | Page |
| footer | ArrowDownToLine | Page |
| navigation | Menu | Page |
| chat | MessageCircle | Interactive |
| map | MapPin | Interactive |
| contact-form | Mail | Interactive |
| newsletter | Mail | Interactive |

### 5. Custom Hooks

#### useTemplateBuilder

```typescript
interface UseTemplateBuilderReturn {
  template: Template | null;
  loading: boolean;
  save: (data: SaveTemplateInput) => Promise<{ data?: any }>;
  applyToStore: (publish?: boolean) => Promise<{ data?: any }>;
  refetch: () => void;
}
```

#### useDesignManagement

```typescript
interface UseDesignManagementReturn {
  designs: Design[];
  themes: Theme[];
  templates: Template[];
  pages: Page[];
  hasDesigns: boolean;
  myTemplates: Template[];
  recommendations: Recommendation[];
  loading: boolean;
  applyTemplate: (templateId: string) => Promise<{ data?: any }>;
  createSmartDesign: (input: any) => Promise<{ data?: any }>;
  refetchMyTemplates: () => void;
  refetchLibrary: () => void;
}
```

### 6. SortableItem Component

**Purpose**: Wrapper for draggable sections using `@dnd-kit/sortable`

**Features**:
- Drag handle with `GripVertical` icon
- Smooth drag animations
- Keyboard accessibility
- Touch support for mobile

### 7. QuickStatsCard Component

**Props**:
| Prop | Type | Description |
|------|------|-------------|
| `label` | `string` | Stat label |
| `value` | `string\|number` | Stat value |
| `icon` | `LucideIcon` | Icon component |
| `color` | `string` | Tailwind color class |
| `change` | `number` | Optional percentage change |

---

*Next: [API Reference](./07-template-editor-api-reference.md)*
