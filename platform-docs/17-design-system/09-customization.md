# 🎨 Customization Guide

## Extending Components

### Creating Custom Components

```typescript
import { useNode } from '@craftjs/core';

const CustomSection = ({ title, children }) => {
  const { connectors: { connect, drag } } = useNode();
  
  return (
    <div ref={ref => connect(drag(ref))}>
      <h2>{title}</h2>
      {children}
    </div>
  );
};

CustomSection.craft = {
  props: { title: 'New Section' },
  related: { toolbar: SectionToolbar }
};
```

### Adding to Resolver

```typescript
const ComponentResolver = {
  ...defaultComponents,
  CustomSection
};
```

## Theming

### Custom Theme

```typescript
const customTheme = {
  colors: {
    primary: '#FF5733',
    secondary: '#33FF57',
    background: '#FFFFFF'
  },
  typography: {
    fontFamily: 'Poppins, sans-serif'
  }
};

<ThemeProvider theme={customTheme}>
  <App />
</ThemeProvider>
```

### Global Styles

```css
/* Custom global styles */
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap');

:root {
  --custom-radius: 12px;
  --custom-transition: 0.3s ease;
}
```

---

*Next: [Troubleshooting](./10-troubleshooting.md)*
