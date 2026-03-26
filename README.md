# <img src="./platform-docs/assets/images/logo.png" width="48" height="48" alt="MG Platform Logo" style="vertical-align: middle;"> MG Platform Architecture Documentation

## Overview
This document provides comprehensive architecture diagrams and documentation for the MG Platform. All documentation is organized in the `platform-docs/` directory with Mermaid diagrams that render automatically on GitHub.

<div align="center">
  <img src="./platform-docs/assets/images/logo.png" alt="MG Platform Logo" width="200">
  <br>
  <em>MG Platform - Unified E-commerce & Service Marketplace</em>
</div>

## Quick Navigation

| Section | Path | Description |
|---------|------|-------------|
| 📚 **Overview** | [platform-docs/00-overview/](./platform-docs/00-overview/) | Platform overview, glossary, user types, tech stack |
| 🏗️ **System Core** | [platform-docs/01-core/](./platform-docs/01-core/) | Users, roles, permissions, platform settings |
| 🛍️ **Marketplace** | [platform-docs/02-marketplace/](./platform-docs/02-marketplace/) | E-commerce, stores, products, orders |
| 💰 **Wallet & Payments** | [platform-docs/03-wallet/](./platform-docs/03-wallet/) | MGPay system, wallets, transactions, commissions |
| 👥 **HR Management** | [platform-docs/04-hr/](./platform-docs/04-hr/) | Jobs, recruitment, employees, payroll |
| 📋 **Project Management** | [platform-docs/05-projects/](./platform-docs/05-projects/) | Projects, bids, contracts, disputes |
| 🏞️ **Land Management** | [platform-docs/06-land/](./platform-docs/06-land/) | Land ownership, heirs, inheritance |
| ⚙️ **Admin Governance** | [platform-docs/07-admin/](./platform-docs/07-admin/) | User management, roles, analytics |
| 📦 **Inventory** | [platform-docs/08-inventory/](./platform-docs/08-inventory/) | Inventory management, warehouses |
| 🎨 **Store Design** | [platform-docs/09-design/](./platform-docs/09-design/) | Themes, templates, preview system |
| 🚚 **Fulfillment** | [platform-docs/10-fulfillment/](./platform-docs/10-fulfillment/) | Order fulfillment, shipping, tracking |
| 📊 **Analytics** | [platform-docs/11-analytics/](./platform-docs/11-analytics/) | Metrics, reports, data export |
| 🔒 **Security** | [platform-docs/12-security/](./platform-docs/12-security/) | Authentication, authorization, compliance |
| 🔌 **API** | [platform-docs/13-api/](./platform-docs/13-api/) | GraphQL API, integrations, webhooks |
| 📈 **Monitoring** | [platform-docs/14-monitoring/](./platform-docs/14-monitoring/) | System health, alerts, recovery |

## System Architecture Diagrams

### Core Diagrams

| # | Diagram | Description |
|---|---------|-------------|
| 01 | [System Core Architecture](./platform-docs/01-core/01-system-core.md) | Users, roles, permissions, and platform settings |
| 02 | [E-commerce & Marketplace](./platform-docs/02-marketplace/02-ecommerce-marketplace.md) | Stores, products, orders, themes, templates |
| 03 | [Wallet & Payment System (MGPay)](./platform-docs/03-wallet/03-wallet-payment.md) | Wallets, transactions, commissions, referrals, tiers |
| 04 | [Jobs, Recruitment & HR Management](./platform-docs/04-hr/04-jobs-hr.md) | Job postings, applications, employees, payroll |
| 05 | [Project & Service Management](./platform-docs/05-projects/05-project-management.md) | Projects, bids, contracts, milestones, disputes |
| 06 | [Land & Inheritance Management](./platform-docs/06-land/06-land-management.md) | Land ownership, heirs, transactions, inheritance |
| 07 | [Admin & Governance](./platform-docs/07-admin/07-admin-governance.md) | User management, roles, analytics, audit logs |

### Database Schemas

| # | Schema | Description |
|---|--------|-------------|
| 01 | [System Core ERD](./platform-docs/01-core/01-system-core-erd.md) | Database schema for users, roles, permissions |
| 03 | [Wallet Database](./platform-docs/03-wallet/03-wallet-payment.md#database-schema) | MGPay accounts, transactions, withdrawals |

## Quick Reference

### Key User Types

| Type | Description | Dashboard |
|------|-------------|-----------|
| **Admin** | Platform administrator with full system access | Admin Panel |
| **Seller** | Store owner selling products | Seller Dashboard |
| **Developer** | App developer selling integrations | Developer Dashboard |
| **Client** | Customer buying products or hiring freelancers | Client Portal |
| **Employee** | Internal staff member | Employee Portal |

### Core Systems

| System | Description | Documentation |
|--------|-------------|---------------|
| **MGPay** | Central payment and wallet system | [03-wallet](./platform-docs/03-wallet/) |
| **Marketplace** | E-commerce engine | [02-marketplace](./platform-docs/02-marketplace/) |
| **HRM** | Human resources management | [04-hr](./platform-docs/04-hr/) |
| **LMS** | Land management system | [06-land](./platform-docs/06-land/) |
| **PMS** | Project management system | [05-projects](./platform-docs/05-projects/) |

### Technology Stack

| Layer | Technologies |
|-------|--------------|
| **Frontend** | React, Next.js, Tailwind CSS, TypeScript |
| **Backend** | Node.js, GraphQL, Apollo Server |
| **Database** | PostgreSQL, MongoDB, Redis |
| **Infrastructure** | Docker, Kubernetes, AWS |
| **Monitoring** | Datadog, Sentry, Logtail |







## Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2026-03-26 | Initial documentation with 14 architecture modules |
| 1.1.0 | 2026-03-26 | Added Mermaid diagrams for all modules |
| 1.2.0 | 2026-03-26 | Complete database schemas and GraphQL API docs |

## License

Copyright © 2026 MGZon Platform. All rights reserved.
