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
