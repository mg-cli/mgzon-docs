# 📊 Chatbot Data Flow

## Complete Message Processing Flow

### State Management

#### Local Component State

| State | Type | Purpose |
|-------|------|---------|
| `messages` | `Message[]` | Chat conversation history |
| `isLoading` | `boolean` | Loading indicator |
| `isChatOpen` | `boolean` | Widget visibility |
| `chatPosition` | `{x, y}` | Draggable position |
| `widgetSettings` | `ChatWidgetSettings` | Current configuration |
| `aiStatus` | `AIStatus` | Usage and limits |
| `geminiKeyStatus` | `GeminiKeyStatus` | API key status |

### Data Validation

#### Input Validation

| Field | Validation | Error Message |
|-------|------------|---------------|
| Message | Not empty | "Please enter a message" |
| API Key | Exists and active | "Configure API key first" |
| Daily Usage | < Limit | "Daily limit reached" |
| AI Status | Enabled | "AI assistant disabled" |

### Caching Strategy

| Cache Type | Key | TTL | Purpose |
|------------|-----|-----|---------|
| Settings | `widget:${sellerId}` | 5 min | Reduce DB reads |
| AI Status | `ai:${sellerId}` | 1 min | Real-time limits |
| API Key Status | `key:${sellerId}` | 5 min | Quick validation |

---

*Next: [Components Overview](./06-chatbot-components.md)*
