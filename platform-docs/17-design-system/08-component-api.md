# 🔌 Component API Reference

## Core Components

### Container

```typescript
interface ContainerProps {
  children: ReactNode;
  maxWidth?: 'xs' | 'sm' | 'md' | 'lg' | 'xl' | false;
  padding?: number | { xs: number; md: number };
  margin?: number;
  center?: boolean;
}
```

### Grid

```typescript
interface GridProps {
  children: ReactNode;
  columns?: number | { xs: number; sm: number; md: number };
  gap?: number | { xs: number; md: number };
  alignItems?: 'start' | 'center' | 'end' | 'stretch';
  justifyContent?: 'start' | 'center' | 'end' | 'between';
}
```

### Button

```typescript
interface ButtonProps {
  children: ReactNode;
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  fullWidth?: boolean;
  loading?: boolean;
  disabled?: boolean;
  onClick?: () => void;
}
```

### Card

```typescript
interface CardProps {
  children: ReactNode;
  variant?: 'default' | 'outline' | 'elevated';
  padding?: number;
  onClick?: () => void;
}
```

---

*Next: [Customization Guide](./09-customization.md)*
