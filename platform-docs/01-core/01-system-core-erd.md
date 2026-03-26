# System Core - Database Schema

## Entity Relationship Diagram

```mermaid
erDiagram
    USERS ||--o{ USER_ROLES : has
    USERS ||--o{ SESSIONS : has
    USERS ||--o{ VERIFICATIONS : has
    USERS ||--o{ NOTIFICATIONS : receives
    
    ROLES ||--o{ USER_ROLES : assigned_to
    ROLES ||--o{ ROLE_PERMISSIONS : has
    
    PERMISSIONS ||--o{ ROLE_PERMISSIONS : assigned_to
    
    USERS {
        uuid id PK
        string email UK
        string password_hash
        string name
        boolean is_active
        boolean email_verified
        string role
        timestamp created_at
        timestamp updated_at
    }
    
    ROLES {
        uuid id PK
        string name UK
        string description
        timestamp created_at
    }
    
    PERMISSIONS {
        uuid id PK
        string name UK
        string description
        string category
        timestamp created_at
    }
    
    USER_ROLES {
        uuid user_id FK
        uuid role_id FK
        timestamp assigned_at
    }
    
    ROLE_PERMISSIONS {
        uuid role_id FK
        uuid permission_id FK
        timestamp assigned_at
    }
    
    SESSIONS {
        uuid id PK
        uuid user_id FK
        string token
        timestamp expires_at
        string ip_address
        string user_agent
        timestamp created_at
    }
    
    NOTIFICATIONS {
        uuid id PK
        uuid user_id FK
        string type
        string title
        string message
        boolean read
        jsonb data
        timestamp created_at
    }
```

## Indexes

```sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_is_active ON users(is_active);
CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_token ON sessions(token);
CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_read ON notifications(read);
```
