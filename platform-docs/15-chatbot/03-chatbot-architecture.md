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
