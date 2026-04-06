# 🎨 Theme Management

## Theme Configuration

### Theme Structure

```typescript
interface Theme {
  name: string;
  colors: {
    primary: string;
    secondary: string;
    background: string;
    surface: string;
    text: string;
    error: string;
    warning: string;
    success: string;
  };
  typography: {
    fontFamily: string;
    fontSize: {
      xs: string;
      sm: string;
      md: string;
      lg: string;
      xl: string;
      '2xl': string;
      '3xl': string;
    };
    fontWeight: {
      normal: number;
      medium: number;
      semibold: number;
      bold: number;
    };
  };
  spacing: {
    xs: string;
    sm: string;
    md: string;
    lg: string;
    xl: string;
  };
  borderRadius: {
    sm: string;
    md: string;
    lg: string;
    full: string;
  };
  shadows: {
    sm: string;
    md: string;
    lg: string;
  };
}
```

### Theme Switching

```typescript
// Use theme provider
<ThemeProvider theme={currentTheme}>
  <App />
</ThemeProvider>

// Access theme in components
const theme = useTheme();
const { colors, typography } = theme;
```

## Dark Mode

| Feature | Implementation |
|---------|----------------|
| Automatic detection | `prefers-color-scheme` |
| Manual toggle | User preference |
| Persistence | Local storage |
| Smooth transition | CSS variables |

## CSS Variables

```css
:root {
  --color-primary: #3B82F6;
  --color-secondary: #6B7280;
  --font-family: 'Inter', sans-serif;
  --spacing-md: 1rem;
}
```

---

*Next: [Responsive Design](./05-responsive-design.md)*
