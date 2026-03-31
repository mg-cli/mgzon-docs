# 🧩 Chatbot Components

## Component Hierarchy

### 1. Chatbote.tsx (Main Widget)

**Purpose**: Main chat interface component

**Props**:
| Prop | Type | Description |
|------|------|-------------|
| `SELLER_ID` | `string` | Seller identifier |

**Key Methods**:
| Method | Description |
|--------|-------------|
| `handleSendMessage()` | Process and send user message |
| `generateResponse()` | Call Gemini API |
| `handleClearChat()` | Clear conversation history |
| `fetchWidgetSettings()` | Load saved configuration |
| `fetchAIStatus()` | Get usage limits |

### 2. ChatWidgetSettings.tsx

**Purpose**: Widget customization panel

**Tabs**:
| Tab | Content |
|-----|---------|
| General | Enable/disable, position, size |
| Appearance | Theme, icon, title, welcome message |
| Colors | Primary, secondary, message backgrounds |
| Advanced | Draggable, resizable, timestamps |

### 3. CopyButton

**Purpose**: One-click copy functionality

**Features**:
- Copy on click
- Visual feedback (checkmark)
- Toast notification
- Hover visibility

### 4. CustomMarkdown

**Purpose**: Enhanced markdown rendering with code copy

**Features**:
- Syntax highlighting support
- Code block copy button
- Inline code styling
- Safe HTML rendering

### 5. TemplatePreview & ProductPreview

**Features**:
- Template name and ID
- Theme information
- Section list
- Price display
- Image gallery
- Copy JSON data

---

*Next: [API Reference](./07-chatbot-api-reference.md)*
