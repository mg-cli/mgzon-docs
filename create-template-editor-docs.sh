#!/bin/bash

# ============================================
# Template Editor Documentation Generator Script
# ============================================
# This script generates complete documentation for
# the Template Editor system including:
# - Drag & Drop sections
# - Live preview
# - Code editor (Developer Mode)
# - Import/Export templates
# - Quick stats
# - Color & font customization
# - Responsive preview
# ============================================

set -e

echo "🚀 Starting Template Editor Documentation Generator..."
echo "========================================================="

cd /workspaces/mgzon-docs/platform-docs

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p 16-template-editor/assets/images

echo "✅ Directory created: 16-template-editor/"

# ============================================
# 01-template-editor-overview.md
# ============================================
echo "📝 Creating 01-template-editor-overview.md..."
cat > 16-template-editor/01-template-editor-overview.md << 'EOF'
# 🎨 Template Editor - Overview

## Introduction

The Template Editor is a powerful **drag-and-drop visual builder** that allows sellers to create, customize, and manage their store templates without writing code. It provides a **WYSIWYG (What You See Is What You Get)** experience with real-time preview.

## Key Features

### 🎯 Core Capabilities

| Feature | Description |
|---------|-------------|
| **Drag & Drop Sections** | Arrange page sections with intuitive drag-and-drop |
| **Live Preview** | See changes instantly as you edit |
| **Responsive Preview** | Test on mobile, tablet, and desktop views |
| **Custom Code Editor** | Advanced mode for HTML/CSS/JS customization |
| **Template Import/Export** | Share templates via JSON/ZIP files |
| **Quick Stats Dashboard** | Track sections, components, and status |

### 🎨 Visual Features

| Feature | Description |
|---------|-------------|
| **Color Picker** | Customize primary, secondary, and background colors |
| **Font Selector** | Choose from multiple web-safe fonts |
| **Theme Switcher** | Light/Dark/Custom themes |
| **Live Color Preview** | See color changes immediately |
| **Background Image** | Upload and set custom backgrounds |

### 📦 Section Types

| Category | Available Sections |
|----------|-------------------|
| **Basic** | Text, Image, Video, Button, Heading, Divider, Spacer |
| **Layout** | Columns, Sidebar |
| **Media** | Carousel, Slider, Gallery, Icon Grid, Image Grid |
| **Content** | Pricing Table, CTA, Accordion, Tabs, Testimonials, FAQ |
| **E-commerce** | Products, Product Card, Collection Banner, Upsell |
| **Interactive** | Animation, Count Up, Popup, Newsletter, Contact Form, Map, Chat |
| **Page** | Hero, Footer, Navigation, Auth Form |

## Target Users

| User Type | Use Case |
|-----------|----------|
| **Sellers** | Build custom store layouts without coding |
| **Designers** | Create reusable templates for clients |
| **Developers** | Add custom code and extend functionality |

## Benefits

| Benefit | Description |
|---------|-------------|
| **No Coding Required** | Build professional layouts visually |
| **Real-time Feedback** | See changes instantly |
| **Reusable Templates** | Save and reuse across stores |
| **Code Freedom** | Advanced mode for custom code |
| **Asset Management** | Upload images, CSS, JS files |

## Documentation Structure

| File | Description |
|------|-------------|
| [01-overview.md](./01-template-editor-overview.md) | Introduction and key features |
| [02-architecture.mmd](./02-template-editor-architecture.mmd) | System architecture diagram |
| [03-architecture.md](./03-template-editor-architecture.md) | Architecture explanation |
| [04-data-flow.mmd](./04-template-editor-data-flow.mmd) | Data flow diagram |
| [05-data-flow.md](./05-template-editor-data-flow.md) | Data flow explanation |
| [06-components.md](./06-template-editor-components.md) | Component breakdown |
| [07-api-reference.md](./07-template-editor-api-reference.md) | API documentation |
| [08-usage-guide.md](./08-template-editor-usage-guide.md) | User guide |
| [09-advanced-features.md](./09-template-editor-advanced-features.md) | Advanced features |
| [10-troubleshooting.md](./10-template-editor-troubleshooting.md) | Common issues |
| [README.md](./README.md) | Module overview |

---

*Documentation Version: 1.0.0*
*Last Updated: April 2026*
EOF
echo "✅ Created: 01-template-editor-overview.md"

# ============================================
# 02-template-editor-architecture.mmd
# ============================================
echo "📝 Creating 02-template-editor-architecture.mmd..."
cat > 16-template-editor/02-template-editor-architecture.mmd << 'EOF'
%%{init: {'theme': 'base', 'themeVariables': {
  'primaryColor': '#3B82F6',
  'primaryTextColor': '#fff',
  'primaryBorderColor': '#1E40AF',
  'lineColor': '#6B7280',
  'secondaryColor': '#F3F4F6',
  'tertiaryColor': '#fff'
}}}%%

graph TB
    subgraph "Client Side"
        direction TB
        TE[TemplateEditor.tsx<br/>Main Component]
        TI[TemplateImporter.tsx<br/>Import/Export]
        TL[TemplateLibrary.tsx<br/>Template Selection]
        CS[CraftSectionRenderer.tsx<br/>Section Rendering]
    end
    
    subgraph "UI Components"
        direction LR
        TABS[Tabs Navigation<br/>6 Main Tabs]
        DND[Drag & Drop<br/>dnd-kit]
        EDITOR[Code Editor<br/>Monaco Editor]
        PREVIEW[Live Preview<br/>Craft.js Frame]
        STATS[Quick Stats Cards<br/>4 Metrics]
    end
    
    subgraph "State Management"
        direction LR
        LS[Local State<br/>useState/useCallback]
        CUSTOM[Custom Hooks<br/>useTemplateBuilder<br/>useDesignManagement]
        CONTEXT[React Context<br/>Theme/Settings]
    end
    
    subgraph "API Layer"
        direction TB
        SAVE[Save Template API<br/>/api/templates/save]
        APPLY[Apply Template API<br/>/api/templates/apply]
        IMPORT[Import Template API<br/>/api/templates/import]
        EXPORT[Export Template API<br/>/api/templates/export]
    end
    
    subgraph "External Services"
        STORAGE[Cloud Storage<br/>Images/Assets]
        MONACO[Monaco Editor<br/>Code Editor]
        CRAFT[Craft.js<br/>Drag & Drop Builder]
    end
    
    subgraph "Database Layer"
        direction LR
        TEMPLATES[(Templates<br/>Collection)]
        SECTIONS[(Sections<br/>Collection)]
        ASSETS[(Assets<br/>Collection)]
        STORES[(Stores<br/>Collection)]
    end
    
    TE --> TABS
    TE --> DND
    TE --> EDITOR
    TE --> PREVIEW
    TE --> STATS
    TE --> LS
    TE --> CUSTOM
    
    TI --> IMPORT
    TI --> EXPORT
    TL --> SAVE
    
    CS --> CRAFT
    
    CUSTOM --> SAVE
    CUSTOM --> APPLY
    IMPORT --> STORAGE
    EXPORT --> STORAGE
    
    SAVE --> TEMPLATES
    SAVE --> SECTIONS
    IMPORT --> TEMPLATES
    IMPORT --> ASSETS
    APPLY --> STORES
    
    style TE fill:#3B82F6,stroke:#1E40AF,color:#fff
    style TI fill:#3B82F6,stroke:#1E40AF,color:#fff
    style TL fill:#3B82F6,stroke:#1E40AF,color:#fff
    style CS fill:#10B981,stroke:#047857,color:#fff
    style DND fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style EDITOR fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style PREVIEW fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style CUSTOM fill:#F59E0B,stroke:#D97706,color:#fff
    style TEMPLATES fill:#EF4444,stroke:#DC2626,color:#fff
EOF
echo "✅ Created: 02-template-editor-architecture.mmd"

# ============================================
# 03-template-editor-architecture.md
# ============================================
echo "📝 Creating 03-template-editor-architecture.md..."
cat > 16-template-editor/03-template-editor-architecture.md << 'EOF'
# 🏗️ Template Editor Architecture

## System Overview

The Template Editor follows a **modular component-based architecture** with clear separation between UI, state management, and API layers.

## Component Breakdown

### 1. Core Components

| Component | File | Responsibility |
|-----------|------|----------------|
| **TemplateEditor** | `TemplateEditor.tsx` | Main container with tabs and state |
| **TemplateImporter** | `TemplateImporter.tsx` | Import from JSON/ZIP/HTML |
| **TemplateLibrary** | `TemplateLibrary.tsx` | Browse and select templates |
| **CraftSectionRenderer** | `CraftSectionRenderer.tsx` | Render individual sections |

### 2. UI Sub-components

| Component | Purpose |
|-----------|---------|
| **Tabs Navigation** | 6 main tabs (General, Sections, Appearance, Content, Developer, Preview) |
| **SortableItem** | Drag & drop wrapper for sections |
| **QuickStats** | Display section count, component count, status |
| **ColorPicker** | Custom color selection with live preview |
| **CodeEditor** | Monaco editor for HTML/CSS/JS |
| **LivePreview** | Craft.js frame for real-time preview |

### 3. Custom Hooks

| Hook | Purpose |
|------|---------|
| `useTemplateBuilder` | Template CRUD operations |
| `useDesignManagement` | Design state management |
| `useTemplateExport` | Export templates as JSON/ZIP |

### 4. Section Types Architecture

```mermaid
graph LR
    subgraph "Section Types"
        BASIC[Basic<br/>Text, Image, Video]
        LAYOUT[Layout<br/>Columns, Sidebar]
        MEDIA[Media<br/>Carousel, Gallery]
        CONTENT[Content<br/>Pricing, FAQ, Tabs]
        ECOMM[E-commerce<br/>Products, Upsell]
        INTERACTIVE[Interactive<br/>Chat, Map, Form]
        PAGE[Page<br/>Hero, Footer, Nav]
    end
    
    BASIC --> RENDERER[CraftSectionRenderer]
    LAYOUT --> RENDERER
    MEDIA --> RENDERER
    CONTENT --> RENDERER
    ECOMM --> RENDERER
    INTERACTIVE --> RENDERER
    PAGE --> RENDERER
    
    RENDERER --> PREVIEW[Live Preview]
```

## Data Flow

### Save Template Flow

1. User clicks **Save**
2. Collects all sections data
3. Sanitizes HTML/CSS/JS
4. Calls `saveTemplate` mutation
5. Stores in `Templates` collection
6. Updates local state

### Import Template Flow

1. User uploads file (JSON/ZIP/HTML)
2. Parses file content
3. Validates against schema
4. Sanitizes content
5. Creates template record
6. Updates UI with imported data

## Security Considerations

### Content Sanitization

| Type | Sanitization Method |
|------|---------------------|
| HTML | `sanitize-html` with allowed tags/attributes |
| CSS | Basic validation, remove dangerous properties |
| JS | Remove `eval()`, `Function()`, dangerous methods |

### File Validation

| File Type | Validation |
|-----------|------------|
| JSON | Schema validation (Zod) |
| ZIP | Check for malicious files |
| HTML | Size limits, tag whitelist |

---

*Next: [Data Flow Diagram](./04-template-editor-data-flow.md)*
EOF
echo "✅ Created: 03-template-editor-architecture.md"

# ============================================
# 04-template-editor-data-flow.mmd
# ============================================
echo "📝 Creating 04-template-editor-data-flow.mmd..."
cat > 16-template-editor/04-template-editor-data-flow.mmd << 'EOF'
%%{init: {'theme': 'base', 'themeVariables': {
  'primaryColor': '#3B82F6',
  'primaryTextColor': '#fff',
  'primaryBorderColor': '#1E40AF',
  'lineColor': '#6B7280',
  'secondaryColor': '#F3F4F6'
}}}%%

flowchart TD
    subgraph USER["User Actions"]
        A[Edit Section]
        B[Drag & Drop]
        C[Add Section]
        D[Save Template]
        E[Import Template]
        F[Export Template]
        G[Toggle Developer Mode]
        H[Change Colors/Fonts]
    end
    
    subgraph UI["UI Layer"]
        A1[Update Form State]
        B1[Reorder Sections]
        C1[Append New Section]
        D1[Collect Template Data]
        E1[Parse File/Code]
        F1[Generate JSON/ZIP]
        G1[Show/Hide Code Editor]
        H1[Update Color Preview]
    end
    
    subgraph STATE["State Management"]
        A2[setSections]
        B2[setSections]
        C2[setSections]
        D2[validateData]
        E2[sanitizeContent]
        F2[formatForExport]
        G2[setIsDeveloperMode]
        H2[setColors/setFont]
    end
    
    subgraph API["API Layer"]
        A3[Save to Database]
        B3[Fetch Templates]
        C3[Import Template]
        D3[Export Template]
    end
    
    subgraph DB["Database"]
        A4[(Templates)]
        B4[(Sections)]
        C4[(Assets)]
    end
    
    subgraph PREVIEW["Live Preview"]
        A5[Update Craft.js Frame]
        B5[Refresh Preview]
        C5[Responsive View]
    end
    
    A --> A1 --> A2 --> A5
    B --> B1 --> B2 --> B5
    C --> C1 --> C2 --> B5
    D --> D1 --> D2 --> A3 --> A4
    E --> E1 --> E2 --> C3 --> A4
    E1 --> E2 --> C4
    F --> F1 --> F2 --> D3
    G --> G1 --> G2
    H --> H1 --> H2 --> A5
    
    style A fill:#3B82F6,stroke:#1E40AF,color:#fff
    style D fill:#10B981,stroke:#047857,color:#fff
    style E fill:#F59E0B,stroke:#D97706,color:#fff
    style F fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style A4 fill:#EF4444,stroke:#DC2626,color:#fff
    style PREVIEW fill:#06B6D4,stroke:#0891B2,color:#fff
EOF
echo "✅ Created: 04-template-editor-data-flow.mmd"

# ============================================
# 05-template-editor-data-flow.md
# ============================================
echo "📝 Creating 05-template-editor-data-flow.md..."
cat > 16-template-editor/05-template-editor-data-flow.md << 'EOF'
# 📊 Template Editor Data Flow

## Complete Data Flow Diagram

### 1. Section Management Flow

```mermaid
sequenceDiagram
    participant U as User
    participant UI as UI Component
    participant State as Local State
    participant Preview as Live Preview
    participant API as Backend API
    
    U->>UI: Add Section
    UI->>State: setSections([...sections, new])
    State->>Preview: Update Craft.js Frame
    Preview->>U: Render New Section
    
    U->>UI: Edit Section Content
    UI->>State: updateSection(index, field, value)
    State->>Preview: Re-render Section
    Preview->>U: Show Updated Content
    
    U->>UI: Drag & Drop Section
    UI->>State: reorderSections()
    State->>Preview: Reorder Sections
    Preview->>U: Show New Order
```

### 2. Save Template Flow

```mermaid
sequenceDiagram
    participant U as User
    participant UI as TemplateEditor
    participant Validate as Validation
    participant API as GraphQL API
    participant DB as Database
    
    U->>UI: Click Save
    UI->>Validate: Collect Template Data
    Validate->>Validate: Sanitize HTML/CSS/JS
    Validate->>Validate: Validate Schema
    Validate->>API: saveTemplate Mutation
    API->>DB: Insert/Update Template
    DB-->>API: Success
    API-->>UI: Success Response
    UI-->>U: Show Toast "Saved!"
```

### 3. Import Template Flow

```mermaid
sequenceDiagram
    participant U as User
    participant Importer as TemplateImporter
    participant Parser as File Parser
    participant Sanitizer as Sanitizer
    participant API as GraphQL API
    participant DB as Database
    
    U->>Importer: Upload File (JSON/ZIP/HTML)
    Importer->>Parser: Read File
    Parser->>Parser: Parse Content
    Parser->>Sanitizer: Raw Data
    Sanitizer->>Sanitizer: Sanitize Content
    Sanitizer->>API: importTemplate Mutation
    API->>DB: Save Template
    DB-->>API: Success
    API-->>Importer: Template Data
    Importer-->>U: Show Imported Template
```

## State Management

### Local State Structure

| State | Type | Initial | Description |
|-------|------|---------|-------------|
| `sections` | `Section[]` | `[]` | Array of page sections |
| `templateName` | `string` | `''` | Template name |
| `theme` | `'light'\|'dark'\|'custom'` | `'light'` | Theme mode |
| `font` | `string` | `'Inter'` | Selected font |
| `colors` | `{primary,secondary,background}` | Default | Color palette |
| `components` | `string[]` | `[]` | Custom components |
| `testimonials` | `Testimonial[]` | `[]` | Testimonials data |
| `isDeveloperMode` | `boolean` | `false` | Developer mode toggle |
| `customCode` | `Record<string, string>` | `{}` | Custom HTML/CSS/JS |
| `isResponsivePreview` | `boolean` | `false` | Mobile preview mode |

### Custom Hooks

| Hook | Returns | Purpose |
|------|---------|---------|
| `useTemplateBuilder` | `{ save, loading, template }` | Template CRUD |
| `useDesignManagement` | `{ designs, themes, templates, pages }` | Design state |
| `useTemplateExport` | `{ exportTemplateAs }` | Export functionality |

## Data Validation

### Section Validation

| Field | Validation Rule |
|-------|-----------------|
| `title` | Required, min 1 char |
| `slug` | Required, URL-friendly |
| `content` | Depends on section type |
| `customHTML` | Sanitized, allowed tags only |
| `customCSS` | Valid CSS syntax |
| `customJS` | Safe JavaScript only |

### File Validation

| File Type | Max Size | Allowed Extensions |
|-----------|----------|-------------------|
| JSON | 10MB | `.json` |
| ZIP | 50MB | `.zip` |
| HTML | 5MB | `.html`, `.htm` |
| Images | 5MB | `.jpg`, `.png`, `.gif`, `.webp` |

---

*Next: [Components Overview](./06-template-editor-components.md)*
EOF
echo "✅ Created: 05-template-editor-data-flow.md"

# ============================================
# 06-template-editor-components.md
# ============================================
echo "📝 Creating 06-template-editor-components.md..."
cat > 16-template-editor/06-template-editor-components.md << 'EOF'
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
EOF
echo "✅ Created: 06-template-editor-components.md"

# ============================================
# 07-template-editor-api-reference.md
# ============================================
echo "📝 Creating 07-template-editor-api-reference.md..."
cat > 16-template-editor/07-template-editor-api-reference.md << 'EOF'
# 🔌 Template Editor API Reference

## GraphQL Mutations

### 1. saveTemplate

Save or update a template.

```graphql
mutation SaveTemplate($input: SaveTemplateInput!) {
  saveTemplate(input: $input) {
    success
    message
    template {
      id
      name
      theme
      font
      colors
      sections {
        id
        type
        content
        position
        customHTML
        customCSS
        customJS
      }
      isPublic
      createdAt
      updatedAt
    }
  }
}
```

**Input Types**:

```graphql
input SaveTemplateInput {
  id: ID
  name: String!
  theme: String!
  font: String!
  colors: ColorInput!
  sections: [SectionInput!]!
  layout: [String!]!
  heroConfig: HeroConfigInput!
  components: [String!]!
  testimonials: [TestimonialInput!]!
  backgroundImage: String
  isPublic: Boolean
  storeId: ID!
}
```

### 2. applyTemplateToStore

Apply a template to a store.

```graphql
mutation ApplyTemplateToStore($templateId: ID!, $storeId: ID!, $publish: Boolean) {
  applyTemplateToStore(templateId: $templateId, storeId: $storeId, publish: $publish) {
    success
    message
    store {
      id
      name
      settings
    }
  }
}
```

### 3. importTemplate

Import a template from file.

```graphql
mutation ImportTemplate($file: Upload!, $storeId: ID!, $sellerId: ID!, $options: ImportOptionsInput) {
  importTemplate(file: $file, storeId: $storeId, sellerId: $sellerId, options: $options) {
    success
    message
    template {
      id
      name
      sections {
        id
        type
        content
      }
    }
  }
}
```

## REST Endpoints

### POST `/api/storage/upload`

Upload asset files (images, CSS, JS).

**Request**: `multipart/form-data`

| Field | Type | Description |
|-------|------|-------------|
| `file` | `File` | Asset file |
| `storeId` | `string` | Store identifier |
| `type` | `string` | `image`\|`css`\|`js`\|`font` |

**Response**:
```json
{
  "success": true,
  "data": {
    "url": "https://cdn.mgzon.com/assets/...",
    "name": "image.png",
    "size": 1024
  }
}
```

## Error Codes

| Code | Status | Description |
|------|--------|-------------|
| `INVALID_TEMPLATE` | 400 | Template data invalid |
| `FILE_TOO_LARGE` | 400 | Exceeds size limit |
| `UNSUPPORTED_FORMAT` | 400 | File type not supported |
| `UNAUTHORIZED` | 401 | Authentication failed |
| `TEMPLATE_NOT_FOUND` | 404 | Template doesn't exist |
| `IMPORT_FAILED` | 500 | Error during import |

## Rate Limits

| Operation | Limit | Per |
|-----------|-------|-----|
| Save Template | 100 | Hour |
| Import Template | 20 | Hour |
| Export Template | 50 | Hour |
| Upload Asset | 50 | Hour |

---

*Next: [Usage Guide](./08-template-editor-usage-guide.md)*
EOF
echo "✅ Created: 07-template-editor-api-reference.md"

# ============================================
# 08-template-editor-usage-guide.md
# ============================================
echo "📝 Creating 08-template-editor-usage-guide.md..."
cat > 16-template-editor/08-template-editor-usage-guide.md << 'EOF'
# 📖 Template Editor Usage Guide

## Getting Started

### Accessing the Template Editor

1. Log in to your **Seller Dashboard**
2. Navigate to **Design → Templates**
3. Click **Create New Template** or **Edit Existing**

### Basic Workflow

```mermaid
graph LR
    A[Create Template] --> B[Add Sections]
    B --> C[Customize Appearance]
    C --> D[Preview]
    D --> E{满意?}
    E -->|Yes| F[Save/Publish]
    E -->|No| B
```

## Tab-by-Tab Guide

### 1. General Tab

**Purpose**: Basic template information and global settings

| Field | Action | Tips |
|-------|--------|------|
| Template Name | Enter name | Use descriptive names |
| Theme | Select Light/Dark/Custom | Preview affects all sections |
| Font | Choose font family | Test on mobile devices |
| Colors | Pick color palette | Use brand colors |
| Public/Private | Toggle switch | Private for testing |

### 2. Sections Tab

**Purpose**: Add, arrange, and edit page sections

#### Adding a Section

1. Click **Add Section** dropdown
2. Select section type from 30+ options
3. Section appears at bottom of list
4. Drag to reorder using handle

#### Editing Section Content

| Section Type | Editable Fields |
|--------------|-----------------|
| Text | Rich text content |
| Image | Image URL, alt text |
| Video | Video URL, poster image |
| Button | Label, URL, style |
| Heading | Text, level (h1-h6) |
| Columns | Number of columns, gap |
| Products | Product IDs, layout |

#### Section Settings

| Setting | Description |
|---------|-------------|
| Title | Section display name |
| Slug | URL-friendly identifier |
| Custom HTML | Advanced HTML override |
| Custom CSS | Section-specific styles |
| Custom JS | Section-specific scripts |

### 3. Appearance Tab

**Purpose**: Hero section, components, and testimonials

#### Hero Configuration

| Field | Description |
|-------|-------------|
| Hero Title | Main headline |
| Hero Subtitle | Supporting text |
| Background Image | Upload or URL |

#### Components Management

- Add custom components by name
- Components appear in section lists
- Use for reusable elements

#### Testimonials Management

| Field | Description |
|-------|-------------|
| Name | Customer name |
| Rating | 1-5 stars |
| Quote | Testimonial text |
| Image URL | Customer photo |

### 4. Content Tab

**Purpose**: Overview of template content

| Stat | What it shows |
|------|---------------|
| Total Sections | Number of sections |
| Active Components | Custom components count |
| Testimonials Count | Number of testimonials |
| Template Status | Public/Private |

### 5. Developer Tab

**Purpose**: Advanced code customization

#### Developer Mode

⚠️ **Warning**: Only for experienced users

| Editor | Purpose |
|--------|---------|
| HTML | Global HTML structure |
| CSS | Global styles |
| JavaScript | Global interactions |

#### Section-Level Code

Each section has individual code editors for:
- Custom HTML
- Custom CSS
- Custom JavaScript

### 6. Preview Tab

**Purpose**: Test template before publishing

#### Preview Modes

| Mode | Icon | Use Case |
|------|------|----------|
| Desktop | Monitor | Test desktop layout |
| Mobile | Smartphone | Test responsive design |

#### Live Preview Features

- Real-time updates
- Interactive elements
- Copy JSON data
- View full site

## Best Practices

### 1. Section Organization

| Tip | Description |
|-----|-------------|
| Logical Order | Header → Content → Footer |
| Group Related | Keep similar sections together |
| Limit Sections | 10-15 sections for performance |

### 2. Performance Optimization

| Practice | Benefit |
|----------|---------|
| Optimize images | Faster loading |
| Minify CSS/JS | Better performance |
| Lazy load sections | Improve initial load |

### 3. Responsive Design

| Breakpoint | Width | Testing |
|------------|-------|---------|
| Mobile | < 768px | Use mobile preview |
| Tablet | 768-1024px | Check spacing |
| Desktop | > 1024px | Full layout |

### 4. Template Management

| Action | Best Practice |
|--------|---------------|
| Naming | Use descriptive names with dates |
| Versioning | Save major versions separately |
| Backup | Export JSON as backup |

---

*Next: [Advanced Features](./09-template-editor-advanced-features.md)*
EOF
echo "✅ Created: 08-template-editor-usage-guide.md"

# ============================================
# 09-template-editor-advanced-features.md
# ============================================
echo "📝 Creating 09-template-editor-advanced-features.md..."
cat > 16-template-editor/09-template-editor-advanced-features.md << 'EOF'
# 🚀 Template Editor Advanced Features

## 1. Advanced Section Management

### Drag & Drop System

Powered by `@dnd-kit` for smooth, accessible drag-and-drop:

| Feature | Description |
|---------|-------------|
| Vertical Sorting | Reorder sections vertically |
| Drag Handle | Grip icon indicates draggable |
| Keyboard Support | Arrow keys for reordering |
| Touch Support | Works on mobile devices |
| Animation | Smooth transitions |

### Section Types Deep Dive

#### Basic Sections

| Type | Configuration | Use Case |
|------|---------------|----------|
| Text | Rich text editor | Long form content |
| Image | URL, alt, caption | Visual elements |
| Video | YouTube/Vimeo URL | Multimedia content |
| Button | Label, URL, style | Calls to action |
| Heading | Level 1-6, text | Section titles |

#### E-commerce Sections

| Type | Features | Integration |
|------|----------|-------------|
| Products | Grid/list, filters, pagination | Product API |
| Product Card | Image, title, price, button | Single product |
| Collection Banner | Image, title, link | Category promotion |
| Upsell | Product recommendations | Cart suggestions |

#### Interactive Sections

| Type | Capabilities |
|------|--------------|
| Chat | AI-powered customer support |
| Map | Interactive location map |
| Contact Form | Custom fields, validation |
| Newsletter | Email collection, integration |

## 2. Live Preview System

### Real-time Updates

```mermaid
graph LR
    A[Edit Content] --> B[Update State]
    B --> C[Craft.js Re-render]
    C --> D[DOM Update]
    D --> E[User Sees Changes]
    
    style A fill:#3B82F6,stroke:#1E40AF,color:#fff
    style E fill:#10B981,stroke:#047857,color:#fff
```

### Preview Features

| Feature | Description |
|---------|-------------|
| **Instant Updates** | Changes appear immediately |
| **Interactive Elements** | Buttons, links work |
| **Responsive Testing** | Mobile/Desktop toggle |
| **Full Site Preview** | Opens in new tab |
| **JSON Export** | Copy template data |

## 3. Code Editor (Monaco)

### Features

| Feature | Description |
|---------|-------------|
| Syntax Highlighting | HTML, CSS, JavaScript |
| Auto-completion | Code suggestions |
| Error Detection | Real-time syntax checking |
| Line Numbers | Easy navigation |
| Find/Replace | Search and replace |
| Multi-cursor | Edit multiple lines |

### Safe Code Execution

| Protection | Implementation |
|------------|----------------|
| HTML Sanitization | `sanitize-html` library |
| CSS Validation | Remove dangerous properties |
| JS Sandbox | No `eval()` or `Function()` |
| XSS Prevention | Escape user input |

## 4. Import/Export System

### Supported Formats

| Format | Content | Use Case |
|--------|---------|----------|
| JSON | Full template data | Backup, sharing |
| ZIP | Template + assets | Complete export |
| HTML | Single page | Quick import |
| Code | HTML/CSS/JS | From scratch |

### Import Process

```mermaid
sequenceDiagram
    participant User
    participant Validator
    participant Sanitizer
    participant Database
    
    User->>Validator: Upload file
    Validator->>Validator: Validate format
    Validator->>Sanitizer: Pass validated data
    Sanitizer->>Sanitizer: Sanitize content
    Sanitizer->>Database: Save template
    Database-->>User: Success
```

### Export Options

| Option | Description |
|--------|-------------|
| Include Assets | Bundle images, fonts |
| Include Metadata | Version, author, date |
| Minify | Compress output |
| Format | JSON or ZIP |

## 5. Quick Stats Dashboard

### Real-time Statistics

| Stat | Calculation |
|------|-------------|
| Sections | `sections.length` |
| Components | `components.length` |
| Testimonials | `testimonials.length` |
| Status | `isPublic ? "Public" : "Private"` |

### Progress Indicator

```typescript
const progress = Math.round((sections.length / 10) * 100);
// Shows visual progress bar
```

## 6. Color & Font Customization

### Color Picker Features

| Feature | Description |
|---------|-------------|
| Hex Input | Manual color entry |
| Color Preview | Live swatch |
| Preset Colors | Common brand colors |
| Opacity | Transparency support |

### Font Options

| Category | Fonts |
|----------|-------|
| Sans-serif | Inter, Roboto, Open Sans |
| Serif | Merriweather, Playfair Display |
| Monospace | Fira Code, JetBrains Mono |
| Custom | Any Google Font |

## 7. Developer Mode

### When to Use

| Scenario | Why |
|----------|-----|
| Custom Layout | Beyond standard sections |
| Complex Animations | Advanced CSS/JS |
| Third-party Integrations | External widgets |
| Performance Tuning | Custom optimization |

### Code Injection Safety

| Type | Safety Measure |
|------|----------------|
| HTML | Whitelist allowed tags |
| CSS | Remove `expression()`, `behavior:` |
| JavaScript | Remove `eval()`, `document.write()` |

## 8. Responsive Preview

### Breakpoints

| Device | Width | Icon |
|--------|-------|------|
| Mobile | 375px | Smartphone |
| Tablet | 768px | Tablet |
| Desktop | 1280px | Monitor |
| Large Desktop | 1920px | Wide monitor |

### Testing Tips

| Test | What to Check |
|------|---------------|
| Touch Targets | Buttons easy to tap |
| Font Size | Readable on small screens |
| Images | Scale properly |
| Layout | No horizontal scroll |

---

*Next: [Troubleshooting](./10-template-editor-troubleshooting.md)*
EOF
echo "✅ Created: 09-template-editor-advanced-features.md"

# ============================================
# 10-template-editor-troubleshooting.md
# ============================================
echo "📝 Creating 10-template-editor-troubleshooting.md..."
cat > 16-template-editor/10-template-editor-troubleshooting.md << 'EOF'
# 🔧 Template Editor Troubleshooting

## Common Issues and Solutions

### 1. Sections Not Saving

| Symptom | Cause | Solution |
|---------|-------|----------|
| Changes lost after refresh | Auto-save disabled | Click Save button manually |
| Validation errors | Invalid data | Check section content |
| Network error | Connection issue | Retry, check internet |

### 2. Drag & Drop Not Working

| Issue | Solution |
|-------|----------|
| Sections won't move | Refresh page, clear cache |
| Drag handle missing | Check section rendering |
| Touch not working | Use mouse on desktop |

### 3. Preview Not Updating

| Cause | Solution |
|-------|----------|
| State not synced | Click Refresh Preview |
| Craft.js error | Check console for errors |
| Slow connection | Wait for re-render |

### 4. Import Fails

| Error | Solution |
|-------|----------|
| "Invalid JSON" | Validate JSON syntax |
| "File too large" | Compress file (<50MB) |
| "Unsupported format" | Use JSON or ZIP only |

### 5. Export Issues

| Problem | Solution |
|---------|----------|
| Missing assets | Check asset paths |
| Empty file | Ensure template has content |
| Corrupted ZIP | Try JSON format instead |

### 6. Code Editor Problems

| Issue | Fix |
|-------|-----|
| Syntax errors | Check console for line numbers |
| Code not executing | Enable Developer Mode |
| Sanitization removes code | Adjust allowed tags |

### 7. Color Picker Issues

| Symptom | Solution |
|---------|----------|
| Colors not applying | Check color format (#RRGGBB) |
| Preview mismatch | Refresh live preview |
| Theme conflicts | Reset to default theme |

## Error Messages

| Error | Meaning | Resolution |
|-------|---------|------------|
| `INVALID_TEMPLATE` | Template data invalid | Validate all fields |
| `SECTION_TYPE_UNKNOWN` | Unrecognized section type | Use supported types |
| `MISSING_REQUIRED_FIELD` | Required field empty | Fill all required fields |
| `IMPORT_FAILED` | File import error | Check file format |
| `EXPORT_FAILED` | Export error | Try again, reduce size |

## Debugging Tools

### Browser Console

```javascript
// Check template state
console.log(sections);
console.log(templateName);

// Test API
fetch('/api/templates/test').then(r => r.json());

// Validate section
const isValid = validateSection(section);
```

### Network Tab

- Check API response status
- Verify request payload
- Look for CORS errors

### Local Storage

```javascript
// View saved templates
localStorage.getItem('template_backup');

// Clear cache
localStorage.removeItem('template_backup');
```

## Performance Issues

| Symptom | Cause | Solution |
|---------|-------|----------|
| Slow rendering | Too many sections | Limit to 15 sections |
| Laggy drag | Heavy DOM | Simplify sections |
| Memory leak | Unmounted components | Refresh page |

## Contact Support

If issues persist:

| Channel | Contact |
|---------|---------|
| Email | `support@mgzon.com` |
| In-app Chat | Available in dashboard |
| Documentation | [Online Help Center](/) |

---

*Back to [Overview](./01-template-editor-overview.md)*
EOF
echo "✅ Created: 10-template-editor-troubleshooting.md"

# ============================================
# README.md
# ============================================
echo "📝 Creating README.md..."
cat > 16-template-editor/README.md << 'EOF'
# 🎨 Template Editor - Documentation

## Module 16: Store Design System

This module documents the advanced **Template Editor** system that allows sellers to create, customize, and manage their store templates through an intuitive drag-and-drop interface.

## 📚 Documentation Structure

| File | Description |
|------|-------------|
| [01-overview.md](./01-template-editor-overview.md) | Introduction and key features |
| [02-architecture.mmd](./02-template-editor-architecture.mmd) | System architecture diagram |
| [03-architecture.md](./03-template-editor-architecture.md) | Architecture explanation |
| [04-data-flow.mmd](./04-template-editor-data-flow.mmd) | Data flow diagram |
| [05-data-flow.md](./05-template-editor-data-flow.md) | Data flow explanation |
| [06-components.md](./06-template-editor-components.md) | Component breakdown |
| [07-api-reference.md](./07-template-editor-api-reference.md) | API documentation |
| [08-usage-guide.md](./08-template-editor-usage-guide.md) | User guide |
| [09-advanced-features.md](./09-template-editor-advanced-features.md) | Advanced features |
| [10-troubleshooting.md](./10-template-editor-troubleshooting.md) | Common issues and solutions |
| [README.md](./README.md) | Module overview |

## 🎯 Key Features

### Core Features

| Feature | Description |
|---------|-------------|
| **Drag & Drop** | Intuitive section rearrangement |
| **30+ Section Types** | Basic, layout, media, e-commerce, interactive |
| **Live Preview** | Real-time WYSIWYG editing |
| **Responsive Testing** | Mobile, tablet, desktop views |
| **Code Editor** | Monaco-based HTML/CSS/JS editor |
| **Import/Export** | JSON, ZIP, HTML formats |
| **Color Picker** | Custom color palette |
| **Font Selector** | 100+ Google Fonts |

### Advanced Features

| Feature | Description |
|---------|-------------|
| **Developer Mode** | Full code access |
| **Custom Components** | Reusable elements |
| **Testimonials** | Customer review management |
| **Quick Stats** | Real-time dashboard |
| **Template Library** | Pre-built templates |
| **Version Control** | Save multiple versions |

## 🏗️ System Requirements

| Component | Requirement |
|-----------|-------------|
| Browser | Modern (Chrome, Firefox, Safari) |
| JavaScript | Enabled |
| Internet | Required for CDN assets |
| Storage | LocalStorage for drafts |

## 📊 Section Type Categories

| Category | Count | Examples |
|----------|-------|----------|
| Basic | 7 | Text, Image, Video, Button |
| Layout | 2 | Columns, Sidebar |
| Media | 5 | Carousel, Gallery, Slider |
| Content | 8 | Pricing, FAQ, Tabs, Testimonials |
| E-commerce | 6 | Products, Upsell, Collection |
| Interactive | 7 | Chat, Map, Form, Newsletter |
| Page | 5 | Hero, Footer, Navigation |

## 🔗 Related Modules

| Module | Description |
|--------|-------------|
| [09-design](../09-design/) | Store design overview |
| [02-marketplace](../02-marketplace/) | E-commerce integration |
| [13-api](../13-api/) | GraphQL API reference |

---

*Module Version: 1.0.0*
*Last Updated: April 2026*
EOF
echo "✅ Created: README.md"

# ============================================
# Update main README.md
# ============================================
echo "📝 Updating main README.md..."
cd /workspaces/mgzon-docs

# Check if the entry already exists
if ! grep -q "16-template-editor" README.md; then
    # Find the line with "15-chatbot" and insert after it
    sed -i '/15-chatbot/a | 16 | **🎨 Template Editor** | [platform-docs/16-template-editor/](./platform-docs/16-template-editor/) | Drag-and-drop template builder with live preview |' README.md
    
    # Add to Quick Navigation table
    sed -i '/| 🎨 **Store Design**/a | **Template Editor** | [platform-docs/16-template-editor/](./platform-docs/16-template-editor/) | Drag-and-drop template builder with 30+ section types |' README.md
fi

echo "✅ Updated main README.md"

# ============================================
# Completion message
# ============================================
echo ""
echo "=================================================="
echo "✅ Template Editor Documentation Complete!"
echo "=================================================="
echo ""
echo "📁 Generated files:"
echo "   - 16-template-editor/01-template-editor-overview.md"
echo "   - 16-template-editor/02-template-editor-architecture.mmd"
echo "   - 16-template-editor/03-template-editor-architecture.md"
echo "   - 16-template-editor/04-template-editor-data-flow.mmd"
echo "   - 16-template-editor/05-template-editor-data-flow.md"
echo "   - 16-template-editor/06-template-editor-components.md"
echo "   - 16-template-editor/07-template-editor-api-reference.md"
echo "   - 16-template-editor/08-template-editor-usage-guide.md"
echo "   - 16-template-editor/09-template-editor-advanced-features.md"
echo "   - 16-template-editor/10-template-editor-troubleshooting.md"
echo "   - 16-template-editor/README.md"
echo ""
echo "📊 Statistics:"
echo "   - 11 documentation files"
echo "   - 2 Mermaid diagrams"
echo "   - Complete API reference"
echo "   - Usage guide with best practices"
echo ""
echo "🎯 Features covered:"
echo "   ✅ Drag & Drop system"
echo "   ✅ 30+ section types"
echo "   ✅ Live preview"
echo "   ✅ Code editor (Monaco)"
echo "   ✅ Import/Export (JSON/ZIP/HTML)"
echo "   ✅ Quick stats dashboard"
echo "   ✅ Color & font customization"
echo "   ✅ Developer mode"
echo "   ✅ Responsive preview"
echo ""
echo "=================================================="
EOF