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
