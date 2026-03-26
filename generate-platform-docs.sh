
#!/bin/bash
# generate-remaining-docs.sh
# Script to generate complete documentation for remaining modules

set -e

echo "========================================="
echo "Generating Remaining Documentation"
echo "========================================="

BASE_DIR="platform-docs"

# الألوان
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# ==========================================
# 02-MARKETPLACE - E-commerce
# ==========================================
print_status "Creating 02-marketplace files..."

cat > "$BASE_DIR/02-marketplace/02-ecommerce-marketplace.md" << 'MARKETPLACE_EOF'
# E-commerce & Marketplace

## Overview
The marketplace module handles all e-commerce functionality including store management, product catalog, orders, and shopping cart operations.

## Architecture Diagram

```mermaid
graph TD
    subgraph MarketplaceCore [Marketplace Core]
        Store[Store]
        Product[Product]
        Category[Category]
        Order[Order]
        Cart[Cart]
        Checkout[Checkout Process]
    end

    subgraph StoreDesign [Store Design]
        Theme[Theme]
        Template[Template]
        PageBuilder[Page Builder]
        StorePreview[Store Preview]
    end

    subgraph Extensions [Extensions]
        Integration[Integration / App]
        Dropshipping[Dropshipping]
        Coupon[Coupon / Promotion]
    end

    Seller[Seller] -- "owns" --> Store
    Store -- "has many" --> Product
    Store -- "applies" --> Theme
    Product -- "belongs to" --> Category

    User[User] -- "adds to" --> Cart
    Cart -- "converts to" --> Order
    Order -- "is processed via" --> Checkout

    Store -- "can install" --> Integration
    Product -- "can be sourced via" --> Dropshipping
    Checkout -- "can apply" --> Coupon
```

## Components

### Store
| Field | Description |
|-------|-------------|
| name | Store name |
| slug | URL-friendly identifier |
| description | Store description |
| logo | Store logo image |
| banner | Store banner image |
| is_published | Whether store is published |
| is_active | Whether store is active |
| is_live | Whether store is live |

### Product
| Field | Description |
|-------|-------------|
| name | Product name |
| slug | URL-friendly identifier |
| description | Product description |
| price | Selling price |
| list_price | Original price |
| count_in_stock | Available quantity |
| category | Product category |
| images | Product images |
| variants | Product variations (color, size) |

### Order
| Field | Description |
|-------|-------------|
| order_number | Unique order identifier |
| status | Order status (pending, processing, shipped, delivered) |
| total_amount | Order total |
| items | Ordered products |
| shipping_address | Delivery address |
| tracking_number | Shipment tracking |

## Database Schema

```sql
-- Stores
CREATE TABLE stores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    seller_id UUID REFERENCES sellers(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    logo VARCHAR(500),
    banner VARCHAR(500),
    is_published BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    is_live BOOLEAN DEFAULT false,
    settings JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Products
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    store_id UUID REFERENCES stores(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    list_price DECIMAL(10,2),
    count_in_stock INT DEFAULT 0,
    category_id UUID REFERENCES categories(id),
    images JSONB,
    attributes JSONB,
    status VARCHAR(20) DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    UNIQUE(store_id, slug)
);

-- Orders
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id UUID REFERENCES users(id),
    store_id UUID REFERENCES stores(id),
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    payment_status VARCHAR(20) DEFAULT 'pending',
    fulfillment_status VARCHAR(20) DEFAULT 'unfulfilled',
    shipping_address JSONB,
    tracking_number VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Order Items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    product_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    variant_data JSONB,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Carts
CREATE TABLE carts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    session_id VARCHAR(255),
    store_id UUID REFERENCES stores(id),
    items JSONB,
    subtotal DECIMAL(10,2) DEFAULT 0,
    total DECIMAL(10,2) DEFAULT 0,
    expires_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

## GraphQL Operations

### Queries
```graphql
type Query {
    # Store queries
    stores(page: Int, limit: Int): StoreConnection!
    storeBySlug(slug: String!): Store!
    myStores: [Store!]!
    
    # Product queries
    products(storeId: ID!, filter: ProductFilter): ProductConnection!
    productBySlug(storeId: ID!, slug: String!): Product!
    featuredProducts(storeId: ID!, limit: Int): [Product!]!
    
    # Category queries
    categories(storeId: ID!): [Category!]!
    categoryBySlug(storeId: ID!, slug: String!): Category!
    
    # Order queries
    orders(storeId: ID!, filter: OrderFilter): OrderConnection!
    orderById(orderId: ID!): Order!
    customerOrders(userId: ID!): [Order!]!
    
    # Cart queries
    cart(storeId: ID!, sessionId: String!): Cart!
}
```

### Mutations
```graphql
type Mutation {
    # Store mutations
    createStore(input: CreateStoreInput!): StoreResponse!
    updateStore(storeId: ID!, input: UpdateStoreInput!): StoreResponse!
    publishStore(storeId: ID!): StoreResponse!
    deleteStore(storeId: ID!): DeleteResponse!
    
    # Product mutations
    createProduct(storeId: ID!, input: ProductInput!): ProductResponse!
    updateProduct(productId: ID!, input: ProductUpdateInput!): ProductResponse!
    deleteProduct(productId: ID!): DeleteResponse!
    updateProductStock(productId: ID!, quantity: Int!, type: String!): StockResponse!
    
    # Order mutations
    createOrder(input: CreateOrderInput!): OrderResponse!
    updateOrderStatus(orderId: ID!, status: String!): OrderResponse!
    addOrderTracking(orderId: ID!, trackingNumber: String!, carrier: String!): OrderResponse!
    cancelOrder(orderId: ID!): OrderResponse!
    
    # Cart mutations
    addToCart(storeId: ID!, input: CartItemInput!): CartResponse!
    updateCartItem(cartId: ID!, itemId: ID!, quantity: Int!): CartResponse!
    removeCartItem(cartId: ID!, itemId: ID!): CartResponse!
    clearCart(cartId: ID!): CartResponse!
    applyCoupon(cartId: ID!, couponCode: String!): CartResponse!
}
```

## Input Types

```graphql
input CreateStoreInput {
    name: String!
    description: String
    logo: Upload
    banner: Upload
    settings: StoreSettingsInput
}

input ProductInput {
    name: String!
    description: String
    price: Float!
    listPrice: Float
    countInStock: Int!
    categoryId: ID
    images: [Upload!]
    variants: [VariantInput!]
    tags: [String!]
    attributes: JSON
}

input CreateOrderInput {
    storeId: ID!
    items: [OrderItemInput!]!
    shippingAddress: AddressInput!
    paymentMethod: String!
    notes: String
}

input CartItemInput {
    productId: ID!
    variantId: ID
    quantity: Int!
}
```

## Response Types

```graphql
type Store {
    id: ID!
    name: String!
    slug: String!
    description: String
    logo: String
    banner: String
    isPublished: Boolean!
    isActive: Boolean!
    isLive: Boolean!
    seller: Seller!
    settings: StoreSettings
    analytics: StoreAnalytics
    createdAt: String!
    updatedAt: String!
    url: String!
    previewUrl: String!
}

type Product {
    id: ID!
    name: String!
    slug: String!
    description: String
    price: Float!
    listPrice: Float
    finalPrice: Float!
    countInStock: Int!
    category: Category
    images: [String!]!
    variants: [Variant!]!
    rating: Float
    numReviews: Int
    tags: [String!]
    attributes: JSON
    createdAt: String!
    updatedAt: String!
    isPublished: Boolean!
}

type Order {
    id: ID!
    orderNumber: String!
    status: OrderStatus!
    paymentStatus: PaymentStatus!
    fulfillmentStatus: FulfillmentStatus!
    totalAmount: Float!
    items: [OrderItem!]!
    shippingAddress: Address!
    trackingNumber: String
    trackingUrl: String
    estimatedDelivery: String
    notes: String
    createdAt: String!
    updatedAt: String!
}
```

## Error Codes

| Code | Description |
|------|-------------|
| STORE_001 | Store not found |
| STORE_002 | Store already exists |
| STORE_003 | Store not published |
| PRODUCT_001 | Product not found |
| PRODUCT_002 | Insufficient stock |
| PRODUCT_003 | Product not published |
| ORDER_001 | Order not found |
| ORDER_002 | Order cannot be cancelled |
| ORDER_003 | Invalid order status |
| CART_001 | Cart not found |
| CART_002 | Item not in cart |
| CART_003 | Cart expired |
| COUPON_001 | Invalid coupon |
| COUPON_002 | Coupon expired |
| COUPON_003 | Coupon usage limit exceeded |

## Related Documentation
- [Inventory Management](../08-inventory/09-inventory-management.md)
- [Order Fulfillment](../10-fulfillment/11-order-fulfillment.md)
- [Store Design](../09-design/10-store-design.md)
MARKETPLACE_EOF

# ==========================================
# 04-HR - Human Resources
# ==========================================
print_status "Creating 04-hr files..."

cat > "$BASE_DIR/04-hr/04-jobs-hr.md" << 'HR_EOF'
# Jobs, Recruitment & HR Management

## Overview
The HR module manages job postings, recruitment, employee records, and payroll processing.

## Architecture Diagram

```mermaid
graph TD
    subgraph Recruitment [Recruitment]
        Job[Job Posting]
        JobApplication[Job Application]
        Interview[Interview Process]
    end

    subgraph HR [HR Management]
        Employee[Employee Record]
        Department[Department]
        Position[Position]
    end

    subgraph Payroll [Payroll]
        Salary[Salary / Payroll]
        Payment[Payment / Receipt]
    end

    Admin[Admin / Manager] -- "creates" --> Job
    User[User / Candidate] -- "submits" --> JobApplication
    JobApplication -- "is processed into" --> Interview
    Interview -- "results in" --> Employee

    Employee -- "assigned to" --> Department
    Employee -- "assigned to" --> Position
    Employee -- "receives" --> Salary
    Salary -- "is processed as" --> Payment
```

## Components

### Job Posting
| Field | Description |
|-------|-------------|
| title | Job title |
| department | Department name |
| location | Job location |
| type | Full-time, part-time, contract |
| experience | Years of experience required |
| salary_range | Min and max salary |
| description | Job description |
| requirements | Required skills and qualifications |
| status | Draft, published, closed |
| deadline | Application deadline |

### Employee Record
| Field | Description |
|-------|-------------|
| employee_id | Unique employee identifier |
| user_id | Linked user account |
| department | Assigned department |
| position | Job position |
| start_date | Employment start date |
| status | Active, terminated, on_leave |
| manager_id | Reporting manager |
| salary | Compensation details |

### Payroll
| Field | Description |
|-------|-------------|
| base_salary | Base compensation |
| bonuses | Performance bonuses |
| deductions | Tax, insurance, loans |
| net_salary | Final payable amount |
| payment_date | Scheduled payment date |
| payment_status | Paid, pending, failed |

## Database Schema

```sql
-- Jobs
CREATE TABLE jobs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    department VARCHAR(100),
    location VARCHAR(255),
    type VARCHAR(50),
    experience VARCHAR(50),
    salary_min DECIMAL(10,2),
    salary_max DECIMAL(10,2),
    description TEXT,
    requirements JSONB,
    status VARCHAR(20) DEFAULT 'draft',
    deadline TIMESTAMP,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Job Applications
CREATE TABLE job_applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    job_id UUID REFERENCES jobs(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id),
    status VARCHAR(20) DEFAULT 'pending',
    personal_info JSONB,
    resume_url VARCHAR(500),
    cover_letter TEXT,
    answers JSONB,
    reviewed_by UUID REFERENCES users(id),
    reviewed_at TIMESTAMP,
    interview_date TIMESTAMP,
    rejection_reason TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Employees
CREATE TABLE employees (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) UNIQUE,
    employee_id VARCHAR(50) UNIQUE NOT NULL,
    department VARCHAR(100),
    position VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) DEFAULT 'active',
    manager_id UUID REFERENCES employees(id),
    permissions JSONB,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Salaries
CREATE TABLE salaries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
    base_amount DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'USD',
    frequency VARCHAR(20) DEFAULT 'monthly',
    bonuses JSONB,
    deductions JSONB,
    net_amount DECIMAL(10,2) GENERATED ALWAYS AS (base_amount - COALESCE((deductions->>'total')::DECIMAL, 0)) STORED,
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'pending',
    payment_reference VARCHAR(100),
    period_start DATE,
    period_end DATE,
    created_at TIMESTAMP DEFAULT NOW(),
    processed_at TIMESTAMP
);
```

## GraphQL Operations

### Queries
```graphql
type Query {
    # Job queries
    jobs(filter: JobFilter, page: Int, limit: Int): JobConnection!
    jobBySlug(slug: String!): Job!
    jobById(id: ID!): Job!
    
    # Application queries
    jobApplications(jobId: ID, status: ApplicationStatus): ApplicationConnection!
    myApplications: [JobApplication!]!
    
    # Employee queries
    employees(department: String, status: EmployeeStatus): [Employee!]!
    employeeById(id: ID!): Employee!
    employeeByUserId(userId: ID!): Employee!
    
    # Payroll queries
    mySalaries(page: Int, limit: Int): SalaryConnection!
    employeeSalaries(employeeId: ID!): [Salary!]!
    salaryStats(employeeId: ID): SalaryStats!
}
```

### Mutations
```graphql
type Mutation {
    # Job mutations
    createJob(input: CreateJobInput!): JobResponse!
    updateJob(id: ID!, input: UpdateJobInput!): JobResponse!
    deleteJob(id: ID!): DeleteResponse!
    updateJobStatus(id: ID!, status: String!): JobResponse!
    
    # Application mutations
    applyForJob(input: JobApplicationInput!): ApplicationResponse!
    updateApplicationStatus(input: UpdateApplicationStatusInput!): ApplicationResponse!
    withdrawApplication(applicationId: ID!): DeleteResponse!
    addApplicationNote(applicationId: ID!, note: String!): ApplicationResponse!
    scheduleInterview(applicationId: ID!, date: String!, type: String!): InterviewResponse!
    
    # Employee mutations
    createEmployee(input: CreateEmployeeInput!): EmployeeResponse!
    updateEmployee(id: ID!, input: UpdateEmployeeInput!): EmployeeResponse!
    terminateEmployee(id: ID!, reason: String!): EmployeeResponse!
    updateEmployeePermissions(id: ID!, permissions: [String!]!): EmployeeResponse!
    assignManager(employeeId: ID!, managerId: ID!): EmployeeResponse!
    
    # Payroll mutations
    processSalary(input: ProcessSalaryInput!): SalaryResponse!
    updateSalaryStatus(id: ID!, status: PaymentStatus!): SalaryResponse!
    generateSalaryReceipt(id: ID!): ReceiptResponse!
    bulkProcessSalaries(departmentId: ID, month: Int!, year: Int!): BulkProcessResponse!
}
```

## Input Types

```graphql
input CreateJobInput {
    title: String!
    department: String!
    location: String!
    type: JobType!
    experience: String!
    salaryMin: Float
    salaryMax: Float
    description: String!
    requirements: [String!]!
    responsibilities: [String!]!
    benefits: [String!]!
    deadline: String!
    maxApplications: Int
    isRemote: Boolean
    contactEmail: String!
    contactPhone: String
}

input JobApplicationInput {
    jobId: ID!
    personalInfo: PersonalInfoInput!
    resume: Upload!
    coverLetter: String
    answers: [AnswerInput!]
    skills: [String!]
    portfolio: String
    linkedin: String
    github: String
}

input CreateEmployeeInput {
    userId: ID!
    department: String!
    position: String!
    startDate: String!
    salary: SalaryInput!
    workSchedule: WorkScheduleInput
    bankDetails: BankDetailsInput
    emergencyContact: EmergencyContactInput
    documents: [DocumentInput!]
}

input ProcessSalaryInput {
    employeeId: ID!
    period: PeriodInput!
    bonuses: BonusInput
    deductions: DeductionInput
    notes: String
}
```

## Response Types

```graphql
type Job {
    id: ID!
    title: String!
    slug: String!
    department: String!
    location: String!
    type: JobType!
    experience: String!
    salary: SalaryRange
    description: String!
    requirements: [String!]!
    responsibilities: [String!]!
    benefits: [String!]!
    skills: [String!]!
    status: JobStatus!
    views: Int!
    applications: Int!
    maxApplications: Int
    isRemote: Boolean!
    company: CompanyInfo
    contactEmail: String!
    contactPhone: String
    createdAt: String!
    updatedAt: String!
    deadline: String!
}

type Employee {
    id: ID!
    userId: ID!
    user: User!
    employeeId: String!
    department: String!
    position: String!
    startDate: String!
    endDate: String
    status: EmployeeStatus!
    manager: Employee
    permissions: [String!]!
    roles: [String!]!
    salary: SalaryDetails!
    bankDetails: BankDetails
    documents: [Document!]!
    emergencyContact: EmergencyContact
    workSchedule: WorkSchedule
    createdAt: String!
    updatedAt: String!
}

type Salary {
    id: ID!
    employeeId: ID!
    baseSalary: SalaryAmount!
    bonuses: Bonuses
    deductions: Deductions
    netSalary: Float!
    paymentDate: String!
    paymentStatus: PaymentStatus!
    receipt: Receipt
    period: Period!
    createdAt: String!
}
```

## Error Codes

| Code | Description |
|------|-------------|
| JOB_001 | Job not found |
| JOB_002 | Job deadline passed |
| JOB_003 | Maximum applications reached |
| APPL_001 | Already applied |
| APPL_002 | Application not found |
| APPL_003 | Cannot withdraw after review |
| EMP_001 | Employee not found |
| EMP_002 | Employee already exists |
| EMP_003 | Invalid department |
| SAL_001 | Salary record not found |
| SAL_002 | Salary already processed |
| SAL_003 | Insufficient funds |

## Related Documentation
- [User Types](../00-overview/03-user-types.md)
- [Wallet & Payment](../03-wallet/03-wallet-payment.md)
- [Security & Compliance](../12-security/13-security-compliance.md)
HR_EOF

# ==========================================
# 05-PROJECTS - Project Management
# ==========================================
print_status "Creating 05-projects files..."

cat > "$BASE_DIR/05-projects/05-project-management.md" << 'PROJECTS_EOF'
# Project & Service Management

## Overview
The project management module enables clients to post projects, freelancers to bid, and manages contracts, milestones, and disputes.

## Architecture Diagram

```mermaid
graph TD
    subgraph ProjectLifecycle [Project Lifecycle]
        Project[Project]
        Bid[Bid / Proposal]
        Contract[Contract]
        Milestone[Milestone]
        Submission[Work Submission]
    end

    subgraph DisputeResolution [Dispute Resolution]
        Dispute[Dispute]
        Evidence[Evidence]
        Resolution[Resolution]
    end

    Client[Client] -- "creates" --> Project
    Employee[Employee / Freelancer] -- "submits" --> Bid
    Project -- "receives" --> Bid
    Client -- "accepts" --> Bid
    Accept -- "creates" --> Contract

    Contract -- "contains" --> Milestone
    Employee -- "submits work to" --> Submission
    Submission -- "is reviewed for" --> Milestone

    Contract -- "can lead to" --> Dispute
    Dispute -- "can include" --> Evidence
    Dispute -- "is resolved by Admin into" --> Resolution
```

## Components

### Project
| Field | Description |
|-------|-------------|
| title | Project title |
| description | Project details |
| budget_type | Fixed price or hourly |
| budget_min | Minimum budget |
| budget_max | Maximum budget |
| deadline | Project deadline |
| skills | Required skills |
| status | Open, in_progress, completed, cancelled |

### Bid
| Field | Description |
|-------|-------------|
| amount | Bid amount |
| delivery_time | Estimated delivery |
| cover_letter | Proposal message |
| attachments | Portfolio items |
| status | Pending, accepted, rejected, withdrawn |

### Contract
| Field | Description |
|-------|-------------|
| project_id | Associated project |
| employee_id | Assigned freelancer |
| amount | Contract amount |
| milestones | Payment milestones |
| status | Active, completed, terminated |
| signed_at | Contract signing date |

### Milestone
| Field | Description |
|-------|-------------|
| title | Milestone name |
| description | Deliverable description |
| amount | Milestone payment |
| due_date | Completion deadline |
| status | Pending, submitted, approved, paid |

## Database Schema

```sql
-- Projects
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    budget_type VARCHAR(20) NOT NULL,
    budget_min DECIMAL(10,2),
    budget_max DECIMAL(10,2),
    deadline TIMESTAMP,
    skills TEXT[],
    status VARCHAR(20) DEFAULT 'open',
    views INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Bids
CREATE TABLE bids (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    employee_id UUID REFERENCES employees(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL,
    delivery_time INT NOT NULL,
    cover_letter TEXT,
    attachments JSONB,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Contracts
CREATE TABLE contracts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    employee_id UUID REFERENCES employees(id),
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    signed_at TIMESTAMP,
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    terms TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Milestones
CREATE TABLE milestones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID REFERENCES contracts(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    amount DECIMAL(10,2) NOT NULL,
    due_date TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pending',
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Disputes
CREATE TABLE disputes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID REFERENCES contracts(id) ON DELETE CASCADE,
    raised_by UUID REFERENCES users(id),
    reason VARCHAR(100) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'open',
    resolution TEXT,
    resolved_by UUID REFERENCES users(id),
    resolved_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);
```

## GraphQL Operations

### Queries
```graphql
type Query {
    # Project queries
    projects(filter: ProjectFilter, page: Int, limit: Int): ProjectConnection!
    projectBySlug(slug: String!): Project!
    projectById(id: ID!): Project!
    myOpenProjects(clientId: ID!): [Project!]!
    myActiveProjects(clientId: ID!): [Project!]!
    myCompletedProjects(clientId: ID!): [Project!]!
    
    # Bid queries
    projectBids(projectId: ID!): [Bid!]!
    bidDetails(projectId: ID!, bidId: ID!): Bid!
    myBids: [Bid!]!
    
    # Contract queries
    clientContracts(clientId: ID!, status: String): [Contract!]!
    contractById(id: ID!): Contract!
    
    # Dispute queries
    clientDisputes(clientId: ID!): [Dispute!]!
    disputeById(id: ID!): Dispute!
}
```

### Mutations
```graphql
type Mutation {
    # Project mutations
    createProject(input: CreateProjectInput!): ProjectResponse!
    updateProject(id: ID!, input: UpdateProjectInput!): ProjectResponse!
    updateProjectStatus(id: ID!, status: ProjectStatus!): ProjectResponse!
    deleteProject(id: ID!): DeleteResponse!
    
    # Bid mutations
    createBid(projectId: ID!, input: BidInput!): BidResponse!
    acceptBid(projectId: ID!, bidId: ID!): ContractResponse!
    rejectBid(bidId: ID!): DeleteResponse!
    withdrawBid(bidId: ID!): DeleteResponse!
    
    # Contract mutations
    submitProject(projectId: ID!, message: String!, files: [Upload!]): SubmissionResponse!
    releasePayment(milestoneId: ID!): PaymentResponse!
    requestRefund(paymentId: ID!, reason: String!): RefundResponse!
    
    # Dispute mutations
    createDispute(input: DisputeInput!): DisputeResponse!
    addDisputeEvidence(disputeId: ID!, input: DisputeEvidenceInput!): EvidenceResponse!
    addDisputeMessage(disputeId: ID!, content: String!): MessageResponse!
}
```

## Input Types

```graphql
input CreateProjectInput {
    title: String!
    description: String!
    budgetType: BudgetType!
    budgetMin: Float
    budgetMax: Float
    deadline: String!
    skills: [String!]!
    experience: String!
    location: String
    isRemote: Boolean!
    attachments: [Upload!]
}

input BidInput {
    amount: Float!
    deliveryTime: Int!
    coverLetter: String!
    attachments: [Upload!]
    milestones: [MilestoneInput!]
}

input DisputeInput {
    projectId: ID!
    contractId: ID!
    reason: String!
    description: String!
    evidence: [DisputeEvidenceInput!]
}
```

## Response Types

```graphql
type Project {
    id: ID!
    title: String!
    slug: String!
    description: String!
    budgetType: BudgetType!
    budgetMin: Float
    budgetMax: Float
    deadline: String!
    skills: [String!]!
    experience: String!
    location: String
    isRemote: Boolean!
    status: ProjectStatus!
    proposals: Int!
    views: Int!
    client: Client!
    createdAt: String!
    updatedAt: String!
}

type Contract {
    id: ID!
    projectId: ID!
    project: Project!
    employee: Employee!
    amount: Float!
    currency: String!
    startDate: String!
    endDate: String!
    status: ContractStatus!
    milestones: [Milestone!]!
    payments: [Payment!]!
    terms: String
    signedAt: String
}

type Dispute {
    id: ID!
    projectId: ID!
    contractId: ID!
    reason: String!
    description: String!
    status: DisputeStatus!
    evidence: [Evidence!]!
    messages: [Message!]!
    resolution: String
    createdAt: String!
    resolvedAt: String
}
```

## Error Codes

| Code | Description |
|------|-------------|
| PROJ_001 | Project not found |
| PROJ_002 | Project already assigned |
| PROJ_003 | Cannot modify closed project |
| BID_001 | Bid not found |
| BID_002 | Bid already exists |
| BID_003 | Cannot bid on own project |
| BID_004 | Bid below minimum |
| CONT_001 | Contract not found |
| CONT_002 | Contract already active |
| CONT_003 | Cannot modify active contract |
| MIL_001 | Milestone not found |
| MIL_002 | Milestone not completed |
| DISP_001 | Dispute not found |
| DISP_002 | Dispute already closed |
| DISP_003 | Cannot dispute resolved contract |

## Related Documentation
- [HR Management](../04-hr/04-jobs-hr.md)
- [Wallet & Payment](../03-wallet/03-wallet-payment.md)
- [Security & Compliance](../12-security/13-security-compliance.md)
PROJECTS_EOF

# ==========================================
# 06-LAND - Land Management
# ==========================================
print_status "Creating 06-land files..."

cat > "$BASE_DIR/06-land/06-land-management.md" << 'LAND_EOF'
# Land & Inheritance Management

## Overview
The land management module handles land ownership records, heir management, land transactions, and Islamic inheritance calculation.

## Architecture Diagram

```mermaid
graph TD
    subgraph LandOwnership [Land Ownership]
        LandOwner[Land Owner]
        Land[Land Parcel]
        Heir[Heir]
    end

    subgraph LandTransactions [Land Transactions]
        LandSale[Sale / Purchase]
        LandTransfer[Ownership Transfer]
        Document[Legal Document]
    end

    subgraph InheritanceCalculation [Inheritance Calculation]
        IslamicShares[Islamic Shares Calculation]
        Distribution[Distribution Plan]
        DisputeLand[Land Dispute]
    end

    LandOwner -- "owns" --> Land
    Land -- "has" --> Heir

    LandSale -- "initiates" --> LandTransfer
    LandTransfer -- "requires" --> Document
    LandTransfer -- "updates" --> LandOwner

    Heir -- "is used in" --> IslamicShares
    IslamicShares -- "generates" --> Distribution
    Distribution -- "is applied to" --> Land
```

## Components

### Land Owner
| Field | Description |
|-------|-------------|
| name | Owner full name |
| national_id | National ID number |
| phone | Contact phone |
| email | Contact email |
| address | Physical address |
| status | Active, deceased |

### Land Parcel
| Field | Description |
|-------|-------------|
| name | Land name/title |
| location | Geographic location |
| original_area | Original land area |
| current_area | Current area after changes |
| price_per_unit | Value per unit area |
| total_value | Total land value |
| status | Available, sold, inherited, disputed |

### Heir
| Field | Description |
|-------|-------------|
| name | Heir full name |
| relation | Relationship to owner |
| share_percentage | Inheritance percentage |
| can_buy | Permission to purchase |
| can_sell | Permission to sell |
| is_alive | Living status |

### Inheritance Calculation (Islamic)
| Heir Type | Share | Conditions |
|-----------|-------|------------|
| Husband | 1/4 or 1/2 | 1/4 if children exist, 1/2 if no children |
| Wife | 1/8 or 1/4 | 1/8 if children exist, 1/4 if no children |
| Son | Residue | After fixed shares |
| Daughter | 1/2 or residue | 1/2 if single, residue if multiple |
| Father | 1/6 or residue | 1/6 if son exists, residue if no son |
| Mother | 1/6 or 1/3 | 1/6 if children exist, 1/3 if no children |

## Database Schema

```sql
-- Land Owners
CREATE TABLE land_owners (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    national_id VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    birth_date DATE,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Land Parcels
CREATE TABLE land_parcels (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID REFERENCES land_owners(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    location VARCHAR(255),
    location_details JSONB,
    original_area DECIMAL(12,2) NOT NULL,
    current_area DECIMAL(12,2) NOT NULL,
    price_per_unit DECIMAL(12,2),
    total_value DECIMAL(15,2) GENERATED ALWAYS AS (current_area * price_per_unit) STORED,
    status VARCHAR(20) DEFAULT 'active',
    coordinates JSONB,
    documents JSONB,
    images TEXT[],
    tags TEXT[],
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Heirs
CREATE TABLE heirs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    land_id UUID REFERENCES land_parcels(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    relation VARCHAR(50) NOT NULL,
    share_percentage DECIMAL(5,2),
    inherited_area DECIMAL(12,2),
    can_buy BOOLEAN DEFAULT false,
    can_sell BOOLEAN DEFAULT false,
    is_alive BOOLEAN DEFAULT true,
    phone VARCHAR(20),
    email VARCHAR(255),
    national_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Land Transactions
CREATE TABLE land_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    land_id UUID REFERENCES land_parcels(id) ON DELETE CASCADE,
    type VARCHAR(20) NOT NULL,
    from_owner_id UUID REFERENCES land_owners(id),
    to_owner_id UUID REFERENCES land_owners(id),
    area DECIMAL(12,2) NOT NULL,
    price DECIMAL(15,2),
    date DATE NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    documents JSONB,
    contract_number VARCHAR(100),
    witness1 VARCHAR(255),
    witness2 VARCHAR(255),
    lawyer_approval BOOLEAN DEFAULT false,
    court_registration BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Inheritance Calculations
CREATE TABLE inheritance_calculations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    land_id UUID REFERENCES land_parcels(id) ON DELETE CASCADE,
    total_area DECIMAL(12,2) NOT NULL,
    total_value DECIMAL(15,2),
    heirs JSONB,
    shares JSONB,
    distribution JSONB,
    remaining_estate DECIMAL(15,2),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

## GraphQL Operations

### Queries
```graphql
type Query {
    # Land queries
    lands(filter: LandFilter, page: Int, limit: Int): LandConnection!
    landById(id: ID!): Land!
    landBySlug(slug: String!): Land!
    landByNationalId(nationalId: String!): [Land!]!
    
    # Owner queries
    landOwners: [LandOwner!]!
    landOwnerById(id: ID!): LandOwner!
    
    # Heir queries
    heirs(landId: ID!): [Heir!]!
    heirDistribution: HeirDistribution!
    
    # Transaction queries
    transactions(filter: TransactionFilter): TransactionConnection!
    transactionById(id: ID!): Transaction!
    
    # Inheritance queries
    inheritanceCalculation(landId: ID!): InheritanceCalculation!
    islamicShares(landId: ID!): IslamicShares!
    
    # Statistics
    landStats: LandStats!
    locationStats: [LocationStat!]!
    heirAnalysis: HeirAnalysis!
}
```

### Mutations
```graphql
type Mutation {
    # Land mutations
    createLand(input: LandOwnerInput!): LandResponse!
    updateLand(id: ID!, input: LandOwnerInput!): LandResponse!
    deleteLand(id: ID!): DeleteResponse!
    updateLandStatus(id: ID!, status: LandStatus!): LandResponse!
    bulkCreateLands(lands: [LandOwnerInput!]!): [Land!]!
    bulkUpdateLands(ids: [ID!]!, updates: LandOwnerInput!): [Land!]!
    bulkDeleteLands(ids: [ID!]!): DeleteResponse!
    
    # Heir mutations
    addHeir(landId: ID!, heir: HeirInput!): LandResponse!
    updateHeir(landId: ID!, heirId: ID!, heir: HeirInput!): LandResponse!
    deleteHeir(landId: ID!, heirId: ID!): LandResponse!
    bulkUpdateHeirs(updates: [HeirBulkUpdateInput!]!): [Heir!]!
    bulkDeleteHeirs(ids: [HeirDeleteInput!]!): DeleteResponse!
    
    # Transaction mutations
    createTransaction(input: TransactionInput!): TransactionResponse!
    updateTransaction(id: ID!, input: TransactionInput!): TransactionResponse!
    deleteTransaction(id: ID!): DeleteResponse!
    updateTransactionStatus(id: ID!, status: TransactionStatus!): TransactionResponse!
    bulkUpdateTransactions(updates: [TransactionBulkUpdateInput!]!): [Transaction!]!
    bulkDeleteTransactions(ids: [ID!]!): DeleteResponse!
    
    # Inheritance mutations
    calculateInheritance(landId: ID!): InheritanceCalculationResponse!
    calculateLandValue(landId: ID!, pricePerUnit: Float): LandValueResponse!
    
    # Import/Export
    importLands(file: Upload!): ImportResponse!
    exportLands(format: String): ExportResponse!
    exportLandsWithFilters(input: ExportInput!): ExportResponse!
    generateReport(input: ReportInput!): ReportResponse!
    scheduleReport(input: ScheduleReportInput!): ScheduledReportResponse!
}
```

## Input Types

```graphql
input LandOwnerInput {
    name: String!
    location: String!
    originalArea: Float!
    currentArea: Float!
    nationalId: String!
    phone: String!
    email: String
    address: String
    birthDate: String
    notes: String
    documents: [Upload!]
    images: [Upload!]
    tags: [String!]
    priority: Int
    coordinates: CoordinatesInput
    metaTitle: String
    metaDescription: String
    keywords: [String!]
}

input HeirInput {
    name: String!
    relation: String!
    sharePercentage: Float
    canBuy: Boolean
    canSell: Boolean
    isAlive: Boolean
    phone: String
    email: String
    nationalId: String
    birthDate: String
    address: String
    notes: String
}

input TransactionInput {
    landId: ID!
    type: TransactionType!
    fromOwnerId: ID
    toOwnerId: ID!
    area: Float!
    price: Float!
    date: String!
    description: String
    documents: [Upload!]
    witness1: String
    witness2: String
    lawyerApproval: Boolean
    courtRegistration: Boolean
    contractNumber: String
    notes: String
}
```

## Response Types

```graphql
type Land {
    id: ID!
    slug: String!
    name: String!
    location: String!
    locationDetails: JSON
    originalArea: Float!
    currentArea: Float!
    addedArea: Float!
    deductions: Float!
    totalResult: Float!
    pricePerUnit: Float
    totalValue: Float
    nationalId: String!
    phone: String!
    email: String
    address: String
    birthDate: String
    heirs: [Heir!]!
    transactions: [Transaction!]!
    notes: String
    documents: [String!]
    tags: [String!]
    priority: Int
    status: LandStatus!
    type: LandType!
    coordinates: Coordinates
    images: [String!]
    videos: [String!]
    attachments: [String!]
    metaTitle: String
    metaDescription: String
    keywords: [String!]
    registrationDate: String
    lastTransactionDate: String
    createdAt: String!
    updatedAt: String!
    createdBy: User
    updatedBy: User
}

type InheritanceCalculation {
    land: Land!
    heirs: [HeirShare!]!
    islamicShares: [IslamicShare!]!
    calculatedShares: [CalculatedShare!]!
    remainingEstate: Float!
    notes: String
}

type IslamicShare {
    relation: String!
    share: String!
    description: String!
}

type LandStats {
    totalLands: Int!
    totalOwners: Int!
    totalArea: Float!
    totalValue: Float!
    activeLands: Int!
    pendingTransactions: Int!
    monthlyGrowth: Float!
    topLocations: [LocationStat!]!
    recentTransactions: [Transaction!]!
}
```

## Islamic Inheritance Rules

### Fixed Sharers (Ashab al-Furud)

| Heir | Share | Condition |
|------|-------|-----------|
| Husband | 1/2 | No children |
| Husband | 1/4 | Has children |
| Wife | 1/4 | No children |
| Wife | 1/8 | Has children |
| Daughter | 1/2 | One daughter only |
| Daughter | 2/3 | Two or more daughters |
| Son's Daughter | 1/2 | One, no son or daughter |
| Son's Daughter | 2/3 | Two or more, no son or daughter |
| Father | 1/6 | Has son |
| Father | Residue | No son |
| Mother | 1/6 | Has children |
| Mother | 1/3 | No children |
| Full Brother | 1/6 | Has one daughter |
| Full Sister | 1/2 | One sister, no children |
| Full Sister | 2/3 | Two or more sisters |

## Error Codes

| Code | Description |
|------|-------------|
| LAND_001 | Land not found |
| LAND_002 | National ID already exists |
| LAND_003 | Invalid area value |
| HEIR_001 | Heir not found |
| HEIR_002 | Invalid share percentage |
| HEIR_003 | Share total exceeds 100% |
| TRANS_001 | Transaction not found |
| TRANS_002 | Invalid transaction type |
| TRANS_003 | Insufficient area |
| INH_001 | Invalid inheritance calculation |
| INH_002 | No heirs found |
| INH_003 | Invalid Islamic share |

## Related Documentation
- [Admin Governance](../07-admin/07-admin-governance.md)
- [Security & Compliance](../12-security/13-security-compliance.md)
LAND_EOF

# ==========================================
# 07-ADMIN - Admin Governance
# ==========================================
print_status "Creating 07-admin files..."

cat > "$BASE_DIR/07-admin/07-admin-governance.md" << 'ADMIN_EOF'
# Admin & Governance

## Overview
The admin module provides comprehensive management capabilities for platform administrators including user management, role configuration, analytics, and operational tools.

## Architecture Diagram

```mermaid
graph TD
    subgraph UserGovernance [User Governance]
        UserMgmt[User Management]
        RoleMgmt[Role & Permission Management]
        ApprovalWorkflow[Approval Workflow]
    end

    subgraph PlatformInsights [Platform Insights]
        Analytics[Platform Analytics]
        Reports[Reports & Exports]
        AuditLog[Audit Log]
    end

    subgraph Operations [Operations]
        BulkOperations[Bulk Actions]
        SystemHealth[System Health Check]
        SettingsMgmt[Platform Settings]
    end

    Admin[Admin] -- "uses" --> UserMgmt
    Admin -- "configures" --> RoleMgmt
    Admin -- "oversees" --> ApprovalWorkflow

    Analytics -- "generates" --> Reports
    SystemHealth -- "records" --> AuditLog
    BulkOperations -- "is logged in" --> AuditLog

    Admin -- "performs" --> BulkOperations
    Admin -- "monitors" --> SystemHealth
    Admin -- "manages" --> SettingsMgmt
```

## Components

### User Management
| Feature | Description |
|---------|-------------|
| User List | View all platform users with filters |
| User Details | View user profile, activity, transactions |
| User Actions | Activate, suspend, delete users |
| User Search | Search by name, email, ID, role |
| User Export | Export user data to CSV/Excel |

### Role & Permission Management
| Feature | Description |
|---------|-------------|
| Role List | View all available roles |
| Role Creation | Create new custom roles |
| Permission Assignment | Assign permissions to roles |
| Role Assignment | Assign roles to users |
| Permission Categories | Group permissions by module |

### Approval Workflows
| Workflow | Description |
|----------|-------------|
| Seller Approval | Review and approve new sellers |
| Developer Approval | Review developer applications |
| Withdrawal Approval | Review large withdrawal requests |
| Theme Approval | Review submitted themes |
| Integration Approval | Review marketplace apps |

### Platform Analytics
| Metric | Description |
|--------|-------------|
| User Growth | New users over time |
| Revenue | Platform revenue trends |
| Transactions | Transaction volume and value |
| Active Stores | Number of active stores |
| App Installs | Marketplace app installs |
| Withdrawal Volume | Total withdrawals processed |

## Database Schema

```sql
-- Admin Actions Log
CREATE TABLE admin_actions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    admin_id UUID REFERENCES users(id),
    action VARCHAR(100) NOT NULL,
    entity_type VARCHAR(50),
    entity_id UUID,
    old_values JSONB,
    new_values JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Approval Requests
CREATE TABLE approval_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    entity_type VARCHAR(50) NOT NULL,
    entity_id UUID NOT NULL,
    requested_by UUID REFERENCES users(id),
    status VARCHAR(20) DEFAULT 'pending',
    notes TEXT,
    reviewed_by UUID REFERENCES users(id),
    reviewed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW()
);

-- System Settings
CREATE TABLE system_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    key VARCHAR(100) UNIQUE NOT NULL,
    value JSONB NOT NULL,
    description TEXT,
    updated_by UUID REFERENCES users(id),
    updated_at TIMESTAMP DEFAULT NOW()
);

-- Reports
CREATE TABLE reports (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL,
    parameters JSONB,
    file_url VARCHAR(500),
    file_size INT,
    status VARCHAR(20) DEFAULT 'pending',
    generated_by UUID REFERENCES users(id),
    generated_at TIMESTAMP,
    expires_at TIMESTAMP,
    download_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- System Health Checks
CREATE TABLE health_checks (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    service VARCHAR(50) NOT NULL,
    status VARCHAR(20),
    response_time INT,
    error_message TEXT,
    checked_at TIMESTAMP DEFAULT NOW()
);
```

## GraphQL Operations

### Queries
```graphql
type Query {
    # User management
    adminUsers(page: Int, limit: Int, search: String, roleFilter: String): AdminUserConnection!
    adminUser(id: ID!): User!
    userPointsHistory(userId: ID!): [PointsHistory!]!
    availableRoles: [String!]!
    
    # Role management
    allPermissions: [Permission!]!
    rolePermissions(role: String!): RolePermissions!
    allRolesPermissions: [RolePermissions!]!
    permissionCategories: [String!]!
    
    # Order management
    adminOrders(page: Int, limit: Int, search: String, status: String): AdminOrderConnection!
    adminOrder(id: ID!): Order!
    adminOrderStats(dateFrom: String, dateTo: String): OrderStats!
    adminOrderChartData(period: String!, dateFrom: String, dateTo: String): ChartData!
    
    # Reports
    recentReports(limit: Int): [Report!]!
    activeAlerts: [Alert!]!
    reportStats: ReportStats!
    earningsReport(period: String): EarningsReport!
    commissionReport(period: String): CommissionReport!
    
    # Withdrawal management
    adminWithdrawals(filter: WithdrawalFilterInput): AdminWithdrawalConnection!
    adminWithdrawalStats: WithdrawalStats!
    adminPayouts(filter: PayoutFilterInput): AdminPayoutConnection!
    adminPayoutAnalytics(filter: PayoutAnalyticsFilter!): PayoutAnalytics!
    adminPayoutSummary: PayoutSummary!
    
    # System
    systemInfo: SystemInfo!
    adminIntegrations(status: String, type: String, search: String): AdminIntegrationConnection!
    pendingApprovals(type: String, page: Int, limit: Int): ApprovalConnection!
    integrationAnalytics(period: String): IntegrationAnalytics!
}
```

### Mutations
```graphql
type Mutation {
    # User management
    updateUserRoles(userId: ID!, roles: [String!]!): UserResponse!
    addUserRole(userId: ID!, role: String!): UserResponse!
    removeUserRole(userId: ID!, role: String!): UserResponse!
    updateUserDetails(userId: ID!, input: UpdateUserInput!): UserResponse!
    toggleUserStatus(userId: ID!, isActive: Boolean!): UserResponse!
    adjustUserPoints(userId: ID!, amount: Int!, description: String!, type: AdjustPointsType!): PointsResponse!
    deleteUser(userId: ID!): DeleteResponse!
    
    # Role management
    updateRolePermissions(role: String!, permissions: [String!]!): RoleResponse!
    resetRolePermissions(role: String!): RoleResponse!
    cloneRolePermissions(fromRole: String!, toRole: String!): RoleResponse!
    
    # Order management
    adminUpdateOrderStatus(id: ID!, status: String!): OrderResponse!
    deleteOrder(id: ID!): DeleteResponse!
    markAsPaid(id: ID!): OrderResponse!
    markAsDelivered(id: ID!): OrderResponse!
    updateTrackingInfo(id: ID!, trackingInfo: TrackingInfoInput!): OrderResponse!
    bulkUpdateOrders(ids: [ID!]!, status: String!): BulkUpdateResponse!
    addOrderNote(id: ID!, note: String!): OrderResponse!
    
    # Payout management
    processPayout(payoutId: ID!, transactionId: String!): PayoutResponse!
    approveWithdrawal(withdrawalId: ID!): WithdrawalResponse!
    rejectWithdrawal(withdrawalId: ID!, reason: String!): WithdrawalResponse!
    bulkUpdatePayouts(payoutIds: [ID!]!, status: PayoutStatus!): BulkUpdateResponse!
    reviewPayoutRisk(input: RiskReviewInput!): RiskReviewResponse!
    updatePayoutStatus(payoutId: ID!, status: PayoutStatus!): PayoutResponse!
    addAdminNote(payoutId: ID!, note: AdminNoteInput!): AdminNoteResponse!
    
    # Settings
    updateSettings(input: SettingsInput!): SettingsResponse!
    updateDeveloperCommissionSettings(input: UpdateDeveloperSettingsInput!): DeveloperSettingsResponse!
    updatePlatformCommission(input: PlatformCommissionInput!): CommissionResponse!
    updateDeveloperSettings(input: UpdateDeveloperSettingsInput!): DeveloperSettingsResponse!
    updatePlatformWarehouseSettings(input: PlatformWarehouseSettingsInput!): WarehouseSettingsResponse!
    
    # Reports
    generateReport(input: ReportInput!): ReportResponse!
    deleteReport(id: ID!): DeleteResponse!
    exportReport(id: ID!, format: String!): ExportResponse!
    shareReport(id: ID!, emails: [String!]!, permission: String!): ShareResponse!
    saveReport(input: SaveReportInput!): ReportResponse!
    updateSavedReport(id: ID!, input: UpdateReportInput!): ReportResponse!
    deleteSavedReport(id: ID!): DeleteResponse!
    
    # Bulk operations
    bulkCreditDevelopers(developerIds: [String!]!, amount: Float!, description: String!): BulkCreditResponse!
    bulkProcessWithdrawals(input: BulkProcessWithdrawalsInput!): BulkProcessResponse!
    bulkApproveThemes(themeIds: [ID!]!): BulkApproveResponse!
    bulkRejectThemes(themeIds: [ID!]!, reason: String!): BulkRejectResponse!
    bulkDeleteWarehouses(input: BulkDeleteWarehousesInput!): BulkDeleteResponse!
    bulkIntegrationOperations(operations: [BulkIntegrationOperation!]!): BulkOperationResponse!
}
```

## Input Types

```graphql
input UpdateUserInput {
    name: String
    email: String
    phone: String
    department: String
    position: String
    isActive: Boolean
}

input SettingsInput {
    site: SiteSettingsInput
    common: CommonSettingsInput
    points: PointsSettingsInput
    marketplace: MarketplaceSettingsInput
    subscriptions: SubscriptionSettingsInput
    languages: [LanguageInput!]
    currencies: [CurrencyInput!]
    paymentMethods: [PaymentMethodInput!]
}

input ReportInput {
    type: ReportType!
    parameters: ReportParametersInput!
    format: ReportFormat!
    schedule: ScheduleInput
    recipients: [String!]
}
```

## Response Types

```graphql
type AdminUserConnection {
    users: [User!]!
    totalPages: Int!
    currentPage: Int!
    totalCount: Int!
}

type RolePermissions {
    role: String!
    roleName: String!
    permissions: [PermissionDetail!]!
}

type Permission {
    name: String!
    description: String!
    category: String!
}

type PermissionDetail {
    name: String!
    description: String!
    category: String!
    enabled: Boolean!
}

type AdminOrderConnection {
    orders: [Order!]!
    totalPages: Int!
    currentPage: Int!
    totalCount: Int!
}

type OrderStats {
    totalOrders: Int!
    totalRevenue: Float!
    averageOrderValue: Float!
    pendingOrders: Int!
    processingOrders: Int!
    shippedOrders: Int!
    deliveredOrders: Int!
    cancelledOrders: Int!
    paidOrders: Int!
    unpaidOrders: Int!
    todayOrders: Int!
    todayRevenue: Float!
    thisWeekOrders: Int!
    thisWeekRevenue: Float!
    thisMonthOrders: Int!
    thisMonthRevenue: Float!
}

type ReportStats {
    totalEarnings: Float!
    earningsGrowth: Float!
    totalUsers: Int!
    newUsersThisMonth: Int!
    totalCommission: Float!
    commissionRate: Float!
    pendingWithdrawals: Float!
    pendingCount: Int!
}

type SystemInfo {
    version: String!
    lastBackup: String!
    totalStorage: Float!
    usedStorage: Float!
    databaseSize: Float!
    uptime: Float!
    activeUsers: Int!
    systemLoad: Float!
}
```

## Permission Categories

| Category | Permissions |
|----------|-------------|
| Users | view_users, create_user, edit_user, delete_user, suspend_user |
| Roles | view_roles, create_role, edit_role, delete_role, assign_role |
| Orders | view_orders, edit_order, cancel_order, refund_order |
| Payments | view_payments, process_payment, refund_payment |
| Withdrawals | view_withdrawals, approve_withdrawal, reject_withdrawal |
| Products | view_products, edit_product, delete_product, publish_product |
| Stores | view_stores, edit_store, suspend_store, approve_store |
| Themes | view_themes, approve_theme, reject_theme, delete_theme |
| Reports | view_reports, generate_report, export_report |
| Settings | view_settings, edit_settings |
| System | view_logs, view_health, clear_cache, run_maintenance |

## Error Codes

| Code | Description |
|------|-------------|
| ADMIN_001 | Insufficient permissions |
| ADMIN_002 | User not found |
| ADMIN_003 | Invalid role |
| ADMIN_004 | Role already exists |
| ADMIN_005 | Cannot delete default role |
| ADMIN_006 | Invalid permission |
| ADMIN_007 | Report not found |
| ADMIN_008 | Report generation failed |
| ADMIN_009 | Invalid settings value |
| ADMIN_010 | Bulk operation failed |
| ADMIN_011 | Approval request not found |
| ADMIN_012 | Cannot approve own request |

## Related Documentation
- [User Types](../00-overview/03-user-types.md)
- [System Core](../01-core/01-system-core.md)
- [Security & Compliance](../12-security/13-security-compliance.md)
ADMIN_EOF

# ==========================================
# Create remaining placeholder directories with basic structure
# ==========================================
print_status "Creating remaining module files..."

# Create basic structure for remaining modules
for module in "08-inventory" "09-design" "10-fulfillment" "11-analytics" "12-security" "13-api" "14-monitoring"; do
    cat > "$BASE_DIR/$module/README.md" << EOF
# $module

## Overview
This module handles $(echo $module | sed 's/[0-9]*-//' | tr '-' ' ') functionality.

## Documentation
Complete documentation will be added here.

## Structure
- Architecture diagrams
- Database schemas
- API documentation
- Use cases

## Related Modules
- [Core](../01-core/)
- [Admin](../07-admin/)
EOF
done

print_success "All remaining documentation files created successfully!"
echo ""
echo "Total files created:"
find "$BASE_DIR" -type f -name "*.md" | wc -l
echo ""
echo "Done!"
