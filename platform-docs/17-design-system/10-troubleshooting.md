# 🔧 Design System Troubleshooting

## Common Issues

### 1. Components Not Rendering

| Symptom | Cause | Solution |
|---------|-------|----------|
| Blank page | Missing resolver | Check ComponentResolver |
| Style missing | CSS not loaded | Import CSS file |
| Props ignored | Wrong prop types | Validate component props |

### 2. Theme Not Applying

| Issue | Solution |
|-------|----------|
| Colors wrong | Check ThemeProvider wrapper |
| Font not loading | Verify font import |
| Dark mode broken | Check localStorage |

### 3. Performance Issues

| Symptom | Solution |
|---------|----------|
| Slow drag | Reduce component complexity |
| Memory leak | Unsubscribe from events |
| Re-render loops | Use React.memo |

## Debugging

### Component Inspector

```typescript
// Log component state
console.log(useNode().props);
console.log(useEditor().query);
```

### Theme Debug

```typescript
// Check current theme
const theme = useTheme();
console.log(theme.colors);
```

### Performance Profiling

```typescript
// React DevTools
// Profiler tab -> Record -> Analyze
```

---

*Back to [Overview](./01-design-system-overview.md)*
