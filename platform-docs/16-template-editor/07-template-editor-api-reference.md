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
