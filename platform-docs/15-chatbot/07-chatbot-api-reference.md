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
