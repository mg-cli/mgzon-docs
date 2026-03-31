#!/bin/bash

# ============================================
# Chatbot Documentation Generator Script
# ============================================

set -e

echo "🚀 Starting Chatbot Documentation Generator..."
echo "=================================================="

cd /workspaces/mgzon-docs/platform-docs

echo "📁 Creating directory structure..."
mkdir -p 15-chatbot/assets/images

echo "✅ Directory created: 15-chatbot/"

# Create 01-chatbot-overview.md
echo "📝 Creating 01-chatbot-overview.md..."
cat > 15-chatbot/01-chatbot-overview.md << 'EOF'
# 🤖 AI Assistant Chatbot - Overview

## Introduction

The AI Assistant Chatbot is an intelligent conversational interface powered by **Google Gemini AI** that helps sellers manage their stores through natural language commands.

## Key Features

### 🎯 Core Capabilities

| Feature | Description | Example Command |
|---------|-------------|-----------------|
| **Product Management** | Create, update, and manage products | "Create a new product called Wireless Headphones for $99.99" |
| **Template Design** | Design and customize store templates | "Create a dark theme template with a hero section" |
| **Store Analytics** | Get sales reports and revenue insights | "Show me my sales report for this month" |
| **Store Settings** | Update configuration and preferences | "Change my store's primary color to blue" |
| **Integration Management** | Connect and manage third-party services | "Connect my Shopify store" |
| **Coupon Management** | Create and manage discount codes | "Create a 20% off coupon for new customers" |

### 🎨 Visual Features

| Feature | Description |
|---------|-------------|
| **Draggable Window** | Move the chat widget anywhere on screen |
| **Resizable** | Adjust window size to preference |
| **Customizable Colors** | Match your store's branding |
| **Multiple Positions** | Choose from 4 corner positions |
| **Typing Indicator** | Visual feedback while AI responds |
| **Copy Functionality** | One-click copy for messages and code |

### 🔒 Security & Privacy

- ✅ API keys are **encrypted** and stored per seller
- ✅ Conversations are **private** to each seller
- ✅ Daily usage limits to **prevent abuse**
- ✅ All data is **isolated** by seller ID

## Target Users

| User Type | Use Case |
|-----------|----------|
| **Sellers** | Manage store operations through chat |
| **Store Managers** | Quick access to store controls |
| **Developers** | Test and debug AI interactions |

## Use Cases

### 1. Quick Product Creation
```
User: "Create a new t-shirt with price $29.99, 100 in stock"
AI: ✅ Product "T-Shirt" created successfully!
    - Price: $29.99
    - Stock: 100
    - Status: Draft
```

### 2. Store Customization
```
User: "Change my store's primary color to #FF5733"
AI: ✅ Store primary color updated to #FF5733
    Live preview updated.
```

### 3. Sales Analytics
```
User: "What were my sales last week?"
AI: 📊 Sales Report (Last 7 Days)
    - Total Revenue: $1,245.50
    - Orders: 42
    - Average Order Value: $29.65
    - Top Product: "Wireless Headphones" ($450.00)
```

### 4. Template Management
```
User: "Create a new template called 'Summer Sale' with blue theme"
AI: ✅ Template "Summer Sale" created!
    - Theme: Blue
    - Sections: 3
    - Created: Just now
```

## Benefits

| Benefit | Description |
|---------|-------------|
| **Time Saving** | Complete tasks in seconds instead of minutes |
| **No Navigation** | Direct commands without menu hunting |
| **24/7 Availability** | AI assistant always ready to help |
| **Consistent Results** | Standardized responses and actions |
| **Learning Curve** | Natural language reduces training needs |

## Limitations

| Limitation | Description |
|------------|-------------|
| **Daily Limits** | Free tier: 50 requests/day |
| **API Key Required** | Must configure Gemini API key |
| **Internet Required** | Requires active connection |
| **Language Support** | Currently English only |

## Next Steps

- [Architecture Overview](./02-chatbot-architecture.md)
- [Setup Guide](./08-chatbot-settings.md)
- [API Reference](./07-chatbot-api-reference.md)

---

*Documentation Version: 1.0.0*  
*Last Updated: March 2026*
EOF
echo "✅ Created: 01-chatbot-overview.md"

# Create 02-chatbot-architecture.mmd
echo "📝 Creating 02-chatbot-architecture.mmd..."
cat > 15-chatbot/02-chatbot-architecture.mmd << 'EOF'
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
        direction LR
        CW[Chat Widget<br/>Chatbote.tsx]
        CS[Settings Panel<br/>ChatWidgetSettings.tsx]
        LS[Local State<br/>React useState]
        PV[Live Preview<br/>Real-time Updates]
    end
    
    subgraph "API Layer"
        direction TB
        CG[Gemini API<br/>/api/seller/chat-gemini]
        WS[Widget Settings API<br/>/api/seller/chat-widget-settings]
        AUTH[Auth Middleware<br/>NextAuth.js]
        RATE[Rate Limiter<br/>Daily Usage]
    end
    
    subgraph "External Services"
        GOOGLE[Google Gemini AI<br/>gemini-1.5-flash]
    end
    
    subgraph "Database Layer"
        direction LR
        SELLER[(Seller Collection<br/>API Keys & Usage)]
        CHAT[(Chat History<br/>Conversation Logs)]
        WIDGET[(Widget Settings<br/>Customization)]
    end
    
    CW --> AUTH
    CS --> AUTH
    AUTH --> CG
    AUTH --> WS
    CG --> RATE
    CG --> SELLER
    CG --> CHAT
    CG --> GOOGLE
    WS --> WIDGET
    CW --> LS
    CS --> LS
    LS --> PV
    CW --> PV
    
    style CW fill:#3B82F6,stroke:#1E40AF,color:#fff
    style CS fill:#3B82F6,stroke:#1E40AF,color:#fff
    style CG fill:#10B981,stroke:#047857,color:#fff
    style WS fill:#10B981,stroke:#047857,color:#fff
    style GOOGLE fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style SELLER fill:#F59E0B,stroke:#D97706,color:#fff
    style CHAT fill:#F59E0B,stroke:#D97706,color:#fff
    style WIDGET fill:#F59E0B,stroke:#D97706,color:#fff
EOF
echo "✅ Created: 02-chatbot-architecture.mmd"

# Create 03-chatbot-architecture.md
echo "📝 Creating 03-chatbot-architecture.md..."
cat > 15-chatbot/03-chatbot-architecture.md << 'EOF'
# 🤖 Chatbot Architecture

## System Overview

The AI Assistant Chatbot follows a **client-server architecture** with clear separation of concerns.

## Component Breakdown

### 1. Frontend Components

| Component | File | Responsibility |
|-----------|------|----------------|
| **Chat Widget** | `Chatbote.tsx` | Main chat interface, message handling, UI rendering |
| **Settings Panel** | `ChatWidgetSettings.tsx` | Widget customization, preview, save/load settings |
| **Integration** | `AdvancedSellerSettings.tsx` | Settings integration into seller dashboard |

### 2. API Routes

| Route | Method | Purpose |
|-------|--------|---------|
| `/api/seller/chat-gemini` | POST | Process user messages, call Gemini AI |
| `/api/seller/chat-widget-settings` | GET | Retrieve widget settings |
| `/api/seller/chat-widget-settings` | PUT | Update widget settings |
| `/api/seller/ai-status` | GET | Get AI usage status |
| `/api/seller/chat-history` | GET/POST | Manage conversation history |
| `/api/seller/gemini-key` | GET | Check Gemini API key status |

### 3. Database Collections

| Collection | Purpose | Key Fields |
|------------|---------|------------|
| **Seller** | Store API keys and usage | `geminiApiKey.key`, `geminiApiKey.dailyUsage` |
| **ChatHistory** | Store conversation history | `sellerId`, `messages[]` |
| **ChatWidgetSettings** | Store widget customization | `colors`, `position`, `size`, `texts` |

### 4. External Services

| Service | Purpose | Model |
|---------|---------|-------|
| **Google Gemini AI** | Natural language processing | `gemini-1.5-flash` |

## Security Considerations

### Authentication
- All API requests require valid session via NextAuth.js
- Seller ID validation ensures data isolation

### Data Isolation
- Each seller has separate: API keys, Chat history, Widget settings, Usage counters

### Rate Limiting
- Daily request limits per seller
- 50 requests/day for free tier
- Configurable limits for premium tiers

### Encryption
- Gemini API keys are encrypted in database
- Sensitive data never exposed to client

## Error Handling

| Error Type | Handling |
|------------|----------|
| Network Failure | Retry with exponential backoff |
| API Key Missing | Show setup instructions with link |
| Daily Limit | Show limit message with upgrade options |
| Invalid Response | Fallback to error message |
| Database Error | Log and return user-friendly message |

---

*Next: [Data Flow Diagram](./04-chatbot-data-flow.md)*
EOF
echo "✅ Created: 03-chatbot-architecture.md"

# Create 04-chatbot-data-flow.mmd
echo "📝 Creating 04-chatbot-data-flow.mmd..."
cat > 15-chatbot/04-chatbot-data-flow.mmd << 'EOF'
%%{init: {'theme': 'base', 'themeVariables': {
  'primaryColor': '#3B82F6',
  'primaryTextColor': '#fff',
  'primaryBorderColor': '#1E40AF',
  'lineColor': '#6B7280',
  'secondaryColor': '#F3F4F6'
}}}%%

flowchart TD
    subgraph INPUT["User Input"]
        A[User Types Message]
        B[Validate Input]
        C{Valid?}
    end
    
    subgraph CHECK["Validation Checks"]
        D{API Key<br/>Configured?}
        E{Daily Limit<br/>Available?}
        F{AI Status<br/>Enabled?}
    end
    
    subgraph ERROR["Error Handling"]
        G[Show Setup<br/>Instructions]
        H[Show Limit<br/>Message]
        I[Show Disabled<br/>Message]
    end
    
    subgraph PROCESS["Processing"]
        J[Send to<br/>Gemini API]
        K[Parse AI<br/>Response]
        L[Update Usage<br/>Counter]
        M[Save to<br/>History]
    end
    
    subgraph OUTPUT["Response"]
        N[Display<br/>Message]
        O[Show Template<br/>Preview]
        P[Show Product<br/>Preview]
        Q[Copy Button<br/>Available]
    end
    
    A --> B --> C
    C -->|No| G
    C -->|Yes| D
    
    D -->|No| G
    D -->|Yes| E
    
    E -->|No| H
    E -->|Yes| F
    
    F -->|No| I
    F -->|Yes| J
    
    J --> K --> L --> M --> N
    N --> O
    N --> P
    N --> Q
    
    style A fill:#3B82F6,stroke:#1E40AF,color:#fff
    style J fill:#10B981,stroke:#047857,color:#fff
    style N fill:#8B5CF6,stroke:#6D28D9,color:#fff
    style G fill:#EF4444,stroke:#DC2626,color:#fff
    style H fill:#F59E0B,stroke:#D97706,color:#fff
    style I fill:#6B7280,stroke:#4B5563,color:#fff
EOF
echo "✅ Created: 04-chatbot-data-flow.mmd"

# Create 05-chatbot-data-flow.md
echo "📝 Creating 05-chatbot-data-flow.md..."
cat > 15-chatbot/05-chatbot-data-flow.md << 'EOF'
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
EOF
echo "✅ Created: 05-chatbot-data-flow.md"

# Create 06-chatbot-components.md
echo "📝 Creating 06-chatbot-components.md..."
cat > 15-chatbot/06-chatbot-components.md << 'EOF'
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
EOF
echo "✅ Created: 06-chatbot-components.md"

# Create 07-chatbot-api-reference.md
echo "📝 Creating 07-chatbot-api-reference.md..."
cat > 15-chatbot/07-chatbot-api-reference.md << 'EOF'
# 🔌 Chatbot API Reference

## Base URL
```
/api/seller/
```

## 1. Chat Gemini API

### POST `/chat-gemini`

**Request Body**:
```json
{
  "prompt": "Create a new product",
  "history": [],
  "SELLER_ID": "seller_123456"
}
```

**Success Response (200)**:
```json
{
  "response": "✅ Product created successfully!",
  "product": { "id": "prod_123", "name": "Product" },
  "usage": { "daily": 5, "limit": 50, "remaining": 45 }
}
```

**Error Codes**:

| Code | Status | Description |
|------|--------|-------------|
| `NO_API_KEY` | 400 | API key not configured |
| `DAILY_LIMIT` | 429 | Daily limit reached |
| `UNAUTHORIZED` | 401 | Authentication failed |

## 2. Widget Settings API

### GET `/chat-widget-settings`

Retrieve widget configuration.

### PUT `/chat-widget-settings`

Update widget configuration.

## Rate Limits

| Tier | Daily Limit | Monthly Limit |
|------|-------------|---------------|
| Free | 50 | 1,500 |
| Pro | 500 | 15,000 |
| Business | 2,000 | 60,000 |

---

*Next: [Settings Guide](./08-chatbot-settings.md)*
EOF
echo "✅ Created: 07-chatbot-api-reference.md"

# Create 08-chatbot-settings.md
echo "📝 Creating 08-chatbot-settings.md..."
cat > 15-chatbot/08-chatbot-settings.md << 'EOF'
# ⚙️ Chatbot Settings Guide

## Accessing Settings

1. Open your **Seller Dashboard**
2. Navigate to **Settings** tab
3. Select **Chat Widget** from the sidebar

## Settings Overview

### General Tab

| Setting | Options | Default |
|---------|---------|---------|
| Enable Chat | On/Off | On |
| Position | 4 corners | Bottom Right |
| Width | 320-700px | 420px |
| Height | 400-800px | 550px |

### Appearance Tab

| Setting | Options | Default |
|---------|---------|---------|
| Theme | Light/Dark/Custom | Light |
| Icon Type | Robot/Chat/Cart/Custom | Robot |
| Title | Text | "AI Assistant" |
| Welcome Message | Text | "👋 Hello! How can I help you?" |

### Colors Tab

| Setting | Default |
|---------|---------|
| Primary Color | #3B82F6 |
| User Message BG | #3B82F6 |
| Assistant Message BG | #F3F4F6 |

### Advanced Tab

| Setting | Default |
|---------|---------|
| Draggable | On |
| Resizable | On |
| Show Timestamp | On |
| Show Typing Indicator | On |
| Persist Position | On |

## Best Practices

### 1. Brand Consistency
- Match widget colors to your store's brand
- Use your logo as custom icon
- Set welcome message with store name

### 2. Performance
- Keep widget size reasonable (420x550 recommended)
- Enable typing indicator for better UX

### 3. Accessibility
- Ensure color contrast meets WCAG standards
- Test with different screen sizes

---

*Next: [Troubleshooting](./09-chatbot-troubleshooting.md)*
EOF
echo "✅ Created: 08-chatbot-settings.md"

# Create 09-chatbot-troubleshooting.md
echo "📝 Creating 09-chatbot-troubleshooting.md..."
cat > 15-chatbot/09-chatbot-troubleshooting.md << 'EOF'
# 🔧 Chatbot Troubleshooting Guide

## Common Issues and Solutions

### 1. Widget Not Showing

| Cause | Solution |
|-------|----------|
| Widget disabled in settings | Enable "Chat Widget" in Settings |
| AI status disabled | Check AI configuration |
| Browser cache | Clear cache and refresh |

### 2. "No API Key" Error

**Solution**:
1. Go to **Settings → Gemini API**
2. Get API key from [Google AI Studio](https://aistudio.google.com/apikey)
3. Paste key and click **Save**

### 3. "Daily Limit Reached" Error

| Option | Description |
|--------|-------------|
| Wait for reset | Limits reset daily at 00:00 UTC |
| Upgrade plan | Get higher limits with Pro/Business |

### 4. Messages Not Sending

**Checklist**:
- [ ] Internet connection active
- [ ] API key valid
- [ ] Daily limit not reached
- [ ] AI status enabled
- [ ] No JavaScript errors (F12 console)

### 5. Copy Button Not Working

**Solutions**:
1. Check browser clipboard permissions
2. Try using keyboard shortcuts (Ctrl+C)
3. Ensure HTTPS (required for clipboard API)

## Error Codes

| Code | Description | Resolution |
|------|-------------|------------|
| `NO_API_KEY` | API key missing | Configure in settings |
| `DAILY_LIMIT` | Rate limit hit | Wait or upgrade |
| `UNAUTHORIZED` | Auth failed | Re-login |

## Debugging Tips

### Browser Console
Open DevTools (F12) and check:
- Network tab for API requests
- Console for JavaScript errors
- Application tab for local storage

## Contact Support

If issues persist, contact:
- Email: `support@mgzon.com`
- In-app chat
- Discord community

---

*Back to [Overview](./01-chatbot-overview.md)*
EOF
echo "✅ Created: 09-chatbot-troubleshooting.md"

# Create README.md
echo "📝 Creating README.md..."
cat > 15-chatbot/README.md << 'EOF'
# 🤖 AI Assistant Chatbot - Documentation

## Module 15: Seller Chat Widget

This module documents the AI-powered chat widget that helps sellers manage their stores through natural language commands.

## 📚 Documentation Structure

| File | Description |
|------|-------------|
| [01-chatbot-overview.md](./01-chatbot-overview.md) | Introduction, features, use cases |
| [02-chatbot-architecture.mmd](./02-chatbot-architecture.mmd) | System architecture diagram |
| [03-chatbot-architecture.md](./03-chatbot-architecture.md) | Architecture explanation |
| [04-chatbot-data-flow.mmd](./04-chatbot-data-flow.mmd) | Data flow diagram |
| [05-chatbot-data-flow.md](./05-chatbot-data-flow.md) | Data flow explanation |
| [06-chatbot-components.md](./06-chatbot-components.md) | Component breakdown |
| [07-chatbot-api-reference.md](./07-chatbot-api-reference.md) | API documentation |
| [08-chatbot-settings.md](./08-chatbot-settings.md) | Settings guide |
| [09-chatbot-troubleshooting.md](./09-chatbot-troubleshooting.md) | Common issues and solutions |

## 🎯 Key Features

- **Natural Language Processing** powered by Google Gemini AI
- **Fully Customizable** appearance (colors, position, size)
- **Draggable & Resizable** window
- **One-click Copy** for messages and code
- **Real-time Preview** in settings
- **Usage Tracking** with daily limits

## 📊 System Requirements

| Component | Requirement |
|-----------|-------------|
| Browser | Modern (Chrome, Firefox, Safari) |
| JavaScript | Enabled |
| Internet | Required |
| Gemini API Key | Required for AI features |

---

*Module Version: 1.0.0*  
*Last Updated: March 2026*
EOF
echo "✅ Created: README.md"

# Summary
echo ""
echo "=================================================="
echo "🎉 Documentation Generation Complete!"
echo "=================================================="
echo ""
echo "📁 Files created in: /workspaces/mgzon-docs/platform-docs/15-chatbot/"
echo ""
ls -la /workspaces/mgzon-docs/platform-docs/15-chatbot/ 2>/dev/null || echo "Directory not found yet"
echo ""
echo "📊 Summary:"
echo "   - 10 documentation files"
echo "   - 2 Mermaid diagram files"
echo "   - 1 assets directory"
echo ""
echo "✅ All files created successfully!"
echo "=================================================="
