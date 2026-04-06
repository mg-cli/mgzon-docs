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
