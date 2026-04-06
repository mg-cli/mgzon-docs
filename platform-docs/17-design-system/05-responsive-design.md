# 📱 Responsive Design

## Breakpoints

| Breakpoint | Width | Tailwind Class | Devices |
|------------|-------|----------------|---------|
| xs | < 640px | `sm:` | Mobile |
| sm | ≥ 640px | `sm:` | Large mobile |
| md | ≥ 768px | `md:` | Tablet |
| lg | ≥ 1024px | `lg:` | Desktop |
| xl | ≥ 1280px | `xl:` | Large desktop |
| 2xl | ≥ 1536px | `2xl:` | Wide desktop |

## Responsive Utilities

### Grid System

```jsx
<Grid
  columns={{ xs: 1, sm: 2, md: 3, lg: 4 }}
  gap={{ xs: 2, md: 4 }}
>
  {items.map(item => <ProductCard key={item.id} {...item} />)}
</Grid>
```

### Typography

```jsx
<Text
  size={{ xs: 'sm', md: 'base', lg: 'lg' }}
  align={{ xs: 'center', md: 'left' }}
>
  Responsive text
</Text>
```

### Spacing

```jsx
<Container
  padding={{ xs: 4, md: 6, lg: 8 }}
  margin={{ xs: 2, md: 4 }}
>
  Content
</Container>
```

## Testing Tools

| Tool | Purpose |
|------|---------|
| **Chrome DevTools** | Device emulation |
| **Responsively App** | Multiple devices |
| **BrowserStack** | Real device testing |

---

*Next: [Accessibility](./06-accessibility.md)*
